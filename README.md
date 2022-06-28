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
It is designed to be extendable and customizable, but with solid defaults.

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
|`:Rumpel`|alias for `:RumpelBase`|
|`:RumpelBase`|Opens an FZF window to search all unicode codepoints (except newline...)|
|`:RumpelEmoji`|Opens an FZF window to search all emoji|

Example mapping:

```vim
nmap <Leader>: :RumpelEmoji
```

## Insert Mode
Insert mode is a little weird because I don't know how to do it better.
The plugin provides the following public functions:

### Insert Mode Functions
|Function|Description|
|-|-|
|`rumpelstiltskin#base_complete()`|Opens a mini FZF pop-up to search all unicode codepoints (except newline...)|
|`rumpelstiltskin#emoji_complete()`|Opens a mini FZF pop-up to search all emoji|

These come with a default mapping (see table below) which can be overwritten
  by assigning a string to the corresponding variable.

### Insert Mode Variables
|Variable|Corresponding function|Default value|
|-|-|-|
|`g:rumpelstiltskin_base_i`|`rumpelstiltskin#base_complete()`|`'<C-X>u'`|
|`g:rumpelstiltskin_emoji_i`|`rumpelstiltskin#emoji_complete()`|`'<C-X>e'`|

Customizing these looks like:

```vim
let g:rumpelstiltskin_base_i = ':base'
```

**NOTE** The way the insert mode customization works requires a restart of vim,
  not just a `source`.
This is the weirdness referred to earlier. Sorry! It's on the roadmap.

# Demo
![rumpelstiltskin_demo](https://user-images.githubusercontent.com/16344962/167204154-ce90dfae-618f-40b9-90e0-479219ebd383.gif)

# Predicted Frequently Asked Questions (PFAQ)
## What are these "Sets"?
Unicode provides various charts for public download.
Each Unicode character has a codepoint and a name, but various combinations of
  that data result in various levels of utility for fuzzy-search functionality.

Here is what's in each:

- **Base** is the set of all the characters with names available from
  unicode.org (see the ruby scripts for the exact source URLs). This is
  supplemented with synonyms from the english-language CLDR data, including
  the text-to-speech data. This is recommended for users that want access to
  the most characters by name possible. Also includes codepoint where
  applicable.
- **Emoji** contains what Unicode describes as "emoji". Each has one name, and
  the group it belongs to (e.g. "face-unwell" is a group including 🥵 and 🤮)

## Why are some of these emoji several characters wide?
Many terminals do not support ZWJ (zero-width join) emoji, and instead
  render all the composite characters and the ZWJ control characters.
Rest assured that a text file that has emoji added with this plugin in vim
  and exported to a format that _does_ support ZWJ, it will render normally.
For example, if you are reading this on GitHub, the following will appear as
  the transgender pride flag, but in most terminals it will appear as its
  composite characters: 🏳‍⚧.

My setup also likes to eat characters after `U+200D` appears. It's super weird.

For the same reason, your fuzzy search window may have some artifacts when it
  scrolls across entries with the ZWJ joiner.
It still works fine and in testing, I found it still totally legible.

# Upcoming changes! (a.k.a. the wishlist)
* Add extension support and documentation for extension
* Add "similar plugins" section
* Supplement math symbols with LaTeX names, where applicable
* Add tutorial/practice file
