# kv help examples

Two examples of `kv help`. See [help.md](help.md) for the usage page.

## List the commands

```
$ kv help
help    show this list
```

The command exits 0 and prints one line per command to stdout.

## Run it with an unknown command

```
$ kv bogus
```

An unknown command prints the usage to stderr and exits 2. Run `kv help` to see the valid commands.
