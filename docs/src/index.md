# Documenter.jl

```@index
```

A set of tools for easier manipulation of line number information. It can be
difficult to reason about line number information when writing macros. However,
it is essential to retain line number information to maintain coverage
statistics. Using this package, line numbers can be directly attached to their
corresponding lines. This prevents errors and makes argument counting more
intuitive.

```@autodocs
Modules = [NumberedLines]
```
