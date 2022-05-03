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

Then, simply use your favorite vim plugin manager. I use `vundle`,
  which looks like this:

# Customization

The keybinds that start the fuzzy search can all be changed!
Each subsection has a table. Here's how to use it:

In your runtime configuration or at runtime, set *variable* to some string other
  than *default*.
What that keybind will do is summarized in *description*.

For ease of editing, paste the following into your runtime configuration:

```vim
let g:rumpelstiltskin_cldr_i='<C-X>:'
let g:rumpelstiltskin_cldr_n='<Leader>:'
```

## CLDR keybinds

|variable                  |default      |description                                             |
|--------------------------|-------------|--------------------------------------------------------|
|`g:rumpelstiltskin_cldr_i`|`'<C-X>:'`   |Fuzzy search in a pop-up from insert mode               |
|`g:rumpelstiltskin_cldr_n`|`'<Leader>:'`|Fuzzy search in your default fzf window from normal mode|

## Vundle
```
Plugin 'izzergh/rumpelstiltskin'
```

# Demo
Here's what it looks like! (I need to find one of them fancy screen-record-into-gif tools)

## Inserting a symbol in normal mode:
![normalsearch](https://user-images.githubusercontent.com/17604174/166576199-221d3c1d-fa8b-4111-b9d0-b14e5c764d96.png)
![normalafter](https://user-images.githubusercontent.com/17604174/166576194-87da78dc-a5af-4e9e-b413-c4862820bfa0.png)

## Inserting a symbol in insert mode:
The pop-up is tiny because I increased the font for legibility, but it works just fine :)
![insertsearch](https://user-images.githubusercontent.com/17604174/166576734-9f0c9d07-b369-4693-9a70-d1fa91c1c2d5.png)
![insertafter](https://user-images.githubusercontent.com/17604174/166576729-bfa95bfb-4a93-4bab-ae27-af773422af22.png)


# Upcoming changes! (a.k.a. the wishlist)
* Add extension support and documentation for extension
* Add "similar plugins" section
* Supplement math symbols with LaTeX names, where applicable
* List sources and include bash scripts for formatting from the source
* Add one of them neat gifs showing the plugin in action
* Add tutorial/practice file
