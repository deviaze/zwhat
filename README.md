# zwhat

Fuzzy `cp` and `mv` commands that use your most recent folders from `zoxide`.

Usage: clone this directory and run `seal r setup` to set up `zwhat` in your `~/.local/bin`.

Consult the source files if you need things moved to a different directory.

You'll also have to add the `zcp` and `zmv` aliases to your shell profile file:

On Linux and Unix-like:

```sh
alias zcp='zwhat cp'
alias zmv='zwhat mv'
```

On Windows:

```pwsh
function zcp { zwhat cp @Args }
function zmv { zwhat mv @Args }
```

Requires the `seal` runtime for luau.
