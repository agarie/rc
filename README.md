# agarie's dotfiles

This repository has two purposes:

1. To have all my dotfiles in one place
2. Forcefully organize this mess

TODO: Linux & MacOS
TODO: setup.sh script
TODO: symlinks to `.config`
TODO: separar coisas em "grupos" para alguém poder aproveitar → acho difícil usar os dotfiles de outros, então o que posso fazer para facilitar caso alguém queira usar os meus?

## A word of warning

Feel free to take inspiration from anything in this repository, but keep in
mind this is made to work with my current setup, so it might need some
tweaking. You can open an issue if you have suggestions and/or questions and
I'll try to help if I can.

## Installation

Install a formatter for Racket so you can use the formatting command `gq` in vim:

```sh
raco pkg install fmt
```

The LSPs for nvim can be installed via [Mason](https://github.com/mason-org/mason.nvim) by opening the TUI with `:Mason` and selecting the ones being used. Refer to the `LSP` section in the `init.lua` file.

It's better to install `solargraph` manually (`gem install solargraph solargraph-rails`) if you work with multiple Ruby versions.

## Z shell

I try to split my Z Shell configuration between the recommended files:

* `.zshenv`: is always sourced and contains `PATH` and other variables that should be set for all types of shells.
* `.zshrc`: is sourced in interactive shells, so scripts using a zsh shebang don't have access to anything defined here.

I also keep a machine-specific `~/.zlocal` file (not on git) that is sourced at the end of `.zshrc`.
