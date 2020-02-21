# Highlight.lua - Neovim
## A Dynamic Syntax Highlighter Using TreeSitter Written In Lua

This plugins aims at making syntax highlighting in neovim better.

It uses neovim's treesitter api to provide color definition for languages that have available parsers.

The main goal is to provide a solid example on how to use this library.

It can be used by those who need better syntax coloring in their neovim environment.

### Notice

- requires neovim v0.5
- Is not usable in the current state

### TODO

- attach the logic to the buffer
- refactor using metatables instead of closures
- detect if parser exists
- finish js colors
- option / command to disable the plugin
- command to handle parser download / build
- find a way to clear the colors from other syntax plugins
- init colors for languages only once
- maybe handle filetype in a better way

### TODO THEN

- provide docs
- get people invested to support more languages

