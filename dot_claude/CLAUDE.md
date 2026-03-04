# Global Claude Instructions

## Git Commits
- Never add `Co-Authored-By` trailers to commit messages.

## Python LSP
- The user has `ty` (astral-sh/ty) installed at `~/.local/bin/ty` as their Python language server.
- Do not prompt to install Pyright, pylsp, or any other Python LSP.

## Rust LSP
- The user has `rust-analyzer` installed at `~/.cargo/bin/rust-analyzer` as their Rust language server.
- Do not prompt to install any other Rust LSP.

## TypeScript LSP
- No TypeScript LSP is installed. Do not prompt to install one unless the user is working on a TypeScript project and explicitly asks.
