# Highlight.lua - Neovim
## A Dynamic Syntax Highlighter Using TreeSitter Written In Lua

## development of this plugin was moved [here](https://github.com/nvim-treesitter/nvim-treesitter)

This plugins aims at making syntax highlighting in neovim better. \
It uses neovim's treesitter api to provide color definition for languages that have available parsers. \
The main goal is to provide a solid example on how to use this library. \
It can be used by those who need better syntax coloring in their neovim environment.

### Notice

- Requires neovim v0.5
- Is usable in the current state only to test and experiment 
- Only js filetypes are supported ATM
- Even though its only to experiment while the neovim team is working on a better api, i still wish people to see what can be done with the treesitter API

### Installing

With plug: `Plug 'nvim-treesitter/highlight.lua'`

You can install parsers running `:InstallTSParser LANGUAGE`. Only `javascript` is available at the moment. \
The command does not work on windows and might not work on every OS. It depends on `git` and `gcc`.

### Screenshot

![alt text](.github/highlight.png?raw=true "javascript highlight"

### Supported Languages
|language|support
|---|---|
|Javascript|Partial (60%)|
|Jsx|None|
|Typescript/tsx|None|
|Rust|None|
|Lua|None|
|C|None|
|C++|None|
|Python|None|
|Ruby|None|
|Go|None|
|Html|None|
|Css|None|
|Php|None|
