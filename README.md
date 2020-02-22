# Highlight.lua - Neovim
## A Dynamic Syntax Highlighter Using TreeSitter Written In Lua

This plugins aims at making syntax highlighting in neovim better.

It uses neovim's treesitter api to provide color definition for languages that have available parsers.

The main goal is to provide a solid example on how to use this library.

It can be used by those who need better syntax coloring in their neovim environment.

### Notice

- Requires neovim v0.5
- Is usable in the current state only to test and experiment 
- Only js filetypes are supported ATM, but you can easily implement your own handlers
- The plugin is under heavy development, it might change a lot or break things.
- Even though its only to experiment while the neovim team is working on a better api, i still wish people to see what can be done with the treesitter API

### Screenshot

![alt text](.github/highlight.png?raw=true "javascript highlight")

### TODO

- detect if parser exists
- find a way to get all the tokens returned by a parser easily (so we should not do it by hand)
- find a way to display properly syntax errors (not working ATM)
- option / command to disable the plugin (can get very slow on huge files)
- command to handle parser download / build
- init colors for languages only once
- handle filetype in a better way

### TODO PERF

- try to do multithreading with luv callbacks instead of doing async rendering (doesnt work great)
- implement async rendering correctly (right now its not really great, still blocking when drawing)

### TODO JS
- JSX

### TODO THEN

- provide docs
- get people invested to support more languages

