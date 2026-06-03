# logrd Notes

This repository is centered on [`src/logrd.bash`](/home/dj/Work/logrd/src/logrd.bash) and its user-facing documentation in [`src/logrd.pod`](/home/dj/Work/logrd/src/logrd.pod).

## What `src/logrd.bash` actually provides

- The file is a bash library, not a standalone program. It is meant to be sourced, and it auto-initializes at load time via `_logrd_init` at the end of the file.
- It manages three logical streams:
  - `stdout` -> fd 1
  - `stderr` -> fd 2
  - `stdlog` -> a dedicated dup of the configured logging fd, defaulting to `stderr`
- Logging levels are ordered `error`, `warn`, `notice`, `info`, `debug`. `_logrd_create-log-facilities` dynamically defines `log-error`, `log-warn`, `log-notice`, `log-info`, `log-debug`, and also redefines `die` to log at `error` level before exiting.
- `logrd-format-message` is the log formatting hook. The default implementation ignores the level argument and echoes the message unchanged.
- Stream redirection is implemented by duplicating and replacing shell file descriptors, with process substitution and `tee` used to support fan-out to:
  - a new target,
  - the original console stream,
  - the previously redirected stream.
- The implementation is explicitly shaped around old bash compatibility. It avoids associative arrays, probes for `{var}>&fd` support, and falls back to scanning free fds starting at `_logrd_STARTING_SAVE_FD`.
- Redirection state is not stacked. `logrd-restore-streams` restores a stream to the state captured when the library was sourced or last re-saved by `logrd-setup`; nested temporary redirections are expected to use subshells.

## Public entry points worth treating as canonical

- `logrd-setup`
- `logrd-set`
- `logrd-get`
- `logrd-redirect-streams`
- `logrd-restore-streams`
- `log-to`
- generated `log-error` / `log-warn` / `log-notice` / `log-info` / `log-debug`
- `logrd_has-error`

The tests call `logrd-redirect-streams`; there is no `logrd-redirect-stream` function in the library.

## Error handling model

- Errors are accumulated in the global `logrd_ERRORS` array.
- `logrd-redirect-streams` and `logrd-restore-streams` clear prior errors at entry via `_logrd_reset-errors`.
- Most internal helpers report failure through `_logrd_error` or `_logrd_errors` rather than writing directly to stderr.
- Because the library works by mutating live file descriptors, rollback paths matter; when changing redirection code, read the save/restore helpers first.

## `src/logrd.pod` versus implementation

The POD now matches the main public shell entry points and option spellings.  The remaining points worth remembering are:

- `src/logrd.pod` has been corrected to use `logrd-redirect-streams` consistently and to document `--fd` / `--file`, which are the spellings accepted by `logrd-redirect-streams`.
- The environment semantics are easy to miss: `_logrd_setup` re-reads the environment after parsing `logrd-setup` options, so matching environment variables can still override values supplied on the command line.
- `README` and `README.md` were not updated in this pass and may still preserve older wording if they were generated from an earlier POD snapshot.

## Implementation traps to keep in mind

- Invalid log levels are now rejected cleanly.  `logrd-set level ...` keeps the prior level unchanged, records the nested `unknown log level` error plus the outer attribute-context error, and source-time env validation is non-fatal while `logrd-setup` remains strict.
- `_logrd_restore-fds` now reports the original fd list correctly when rollback fails, and `tests/streams.bats` contains dedicated failure-path coverage for both direct restore failure and `logrd-redirect-streams` rollback propagation.
- `stdlog` is not just an alias for fd 2 after initialization. It is a saved/redirectable fd returned by `logrd-get stdlog`, and callers may write directly to it.
- `logrd-redirect-streams` now tracks call-level copy defaults separately from per-stream overrides.  Options before any stream apply to the whole call; options after a stream apply only to that preceding stream; repeated `--copy-to-console` / `--copy-to-stream` toggles within one call are covered by `tests/streams.bats`; and `_logrd_COPIED_TO_CONSOLE` still tracks whether a stream has already been wired to console for later redirects.

## Practical reading order

When modifying this library, start in this order:

1. `_logrd_init`, `_logrd_save-fds`, `_logrd_setup`
2. `_logrd_reserve-fds`, `_logrd_dup-fd`, `_logrd_move-fd`, `_logrd_redirect-fd`, `_logrd_tee-fd`
3. `logrd-redirect-streams` and `logrd-restore-streams`
4. `src/logrd.pod` to decide whether code or docs are the current source of truth for the change
