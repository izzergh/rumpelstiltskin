 ```
.____                             _     _   _ _ _       _    _
|  _ \ _   _ _ __ ___  _ __   ___| |___| |_(_) | |_ ___| | _(_)_ __
| |_) | | | | '_ ` _ \| '_ \ / _ \ / __| __| | | __/ __| |/ / | '_ \
|  _ <| |_| | | | | | | |_) |  __/ \__ \ |_| | | |_\__ \   <| | | | |
|_| \_\\__,_|_| |_| |_| .__/ \___|_|___/\__|_|_|\__|___/_|\_\_|_| |_|
~~~~~~~~~~~~~~~~~~~~~~|_|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ```

Gain power over a symbol by knowing its name.

This is a vim plugin that lets you fuzzy search for Unicode symbols.
It uses the completion functionality provided by [fzf.vim](https://github.com/junegunn/fzf.vim)
  and thus that's a dependency.
It is deisgned to be extendable and customizable, but with solid defaults.

# Caveat
This is my first plugin, so it may do something that breaks your general setup.
I tried to avoid that where I thought it would come up, (e.g. using `fzf#wrap`
  where applicable) but I probably missed something.
Issues and PRs are welcome in that case, just please be kind!

# Installation
First, install `fzf.vim`. **This plugin will not work without `fzf.vim`**.

Then, simply use your favorite vim plugin manager:

## Vundle
```
Plugin 'izzergh/rumpelstiltskin'
```

## Vim-Plug
```
Plug 'izzergh/rumpelstiltskin'
```

# Customization

Normal mode and Insert mode keybinds are configurable in separate ways because
  insert mode commands are weird and I don't quite get how to use them!

## Normal Mode

Installing this plugin gives you the following commands:

### Normal Mode Commands
|Command|Description|
|-|-|
|`:RumpelCLDR`|Opens an FZF window to search the [CLDR](https://cldr.unicode.org/#h.59ffxi4tj4wz) set of Unicode characters|

Example mapping:

```vim
nmap <Leader>: :RumpelCLDR
```

## Insert Mode
Insert mode is a little weird because I don't know how to do it better.
The plugin provides the following public functions:

### Insert Mode Functions
|Function|Description|
|-|-|
|`rumpelstiltskin#cldr_complete()`|Opens a mini FZF pop-up to search the [CLDR](https://cldr.unicode.org/#h.59ffxi4tj4wz) set of Unicode characters|

These come with a default mapping (see table below) which can be overwritten
  by assigning a string to the corresponding variable.

### Insert Mode Variables
|Variable|Corresponding function|Default value|
|-|-|-|
|`g:rumpelstiltskin_cldr_i`|`rumpelstiltskin#cldr_complete()`|`'<C-X>:'`|

Customizing these looks like:

```vim
let g:rumpelstiltskin_cldr_i = ':cldr'
```

**NOTE** The way the insert mode customization works requires a restart of vim,
  not just a `source`.
This is the weirdness referred to earlier. Sorry! It's on the roadmap.

# Demo
![rumpelstiltskin_demo](https://user-images.githubusercontent.com/16344962/167204154-ce90dfae-618f-40b9-90e0-479219ebd383.gif)

# Upcoming changes! (a.k.a. the wishlist)
* Add extension support and documentation for extension
* Add "similar plugins" section
* Supplement math symbols with LaTeX names, where applicable
* List sources and include bash scripts for formatting from the source
* Add one of them neat gifs showing the plugin in action
* Add tutorial/practice file
