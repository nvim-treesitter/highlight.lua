# Highlight.lua - Neovim
## A Dynamic Syntax Highlighter Using TreeSitter Written In Lua

This plugins aims at making syntax highlighting in neovim better. \
It uses neovim's treesitter api to provide color definition for languages that have available parsers. \
The main goal is to provide a solid example on how to use this library. \
It can be used by those who need better syntax coloring in their neovim environment.

### Development of this plugin will continue when the treesitter api becomes more stable

### Notice

- Requires neovim v0.5
- Is usable in the current state only to test and experiment 
- Only js filetypes are supported ATM
- The plugin is under heavy development, it might change a lot or break things.
- Even though its only to experiment while the neovim team is working on a better api, i still wish people to see what can be done with the treesitter API

### Installing

With plug: `Plug 'kyazdani42/highlight.lua'`

You can install parsers running `:InstallTSParser LANGUAGE`. Only `javascript` is available at the moment. \
The command does not work on windows and might not work on every OS. It depends on `git` and `gcc`.

### Screenshot

![alt text](.github/highlight.png?raw=true "javascript highlight")

### TODO

- Should warn the user to setup some colors for this plugin to work in case `g:terminal_color_[0-15]` are not defined
- Option to disable the plugin on some languages
- Option / command to disable the plugin
- Command to list available languages
- Better filetype handling
- Provide docs

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
