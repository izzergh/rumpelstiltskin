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

# Demo
![rumpelstiltskin_demo](https://user-images.githubusercontent.com/17604174/176318444-af4b3078-5602-4857-a1ee-b36ef88b5229.gif)

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
The plugin provides the following public functions:

### Insert Mode Functions and Defaults
|Function|Default Mapping|Description|
|-|-|-|
|`rumpelstiltskin#base_complete()`|`'<C-X>u'`|Opens a mini FZF pop-up to search all unicode codepoints (except newline...)|
|`rumpelstiltskin#emoji_complete()`|`'<C-X>e'`|Opens a mini FZF pop-up to search all emoji|

Example mapping:

```vim
imap <expr> <Leader>: rumpelstiltskin#base_complete()
```

## Sets
**TODO** see issue #27 for progress or to add suggestions.
Currently, you can chase down the source file and replace it with something of
  the same format, which is Not Great.

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
