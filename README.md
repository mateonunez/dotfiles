# 📁 dotfiles

<img width="1512" alt="image" src="https://github.com/mateonunez/dotfiles/assets/11861080/86512709-8141-464a-874e-c138849c11c6">

## ✨ What is this?

This is my personal dotfiles repository. It contains all the configuration files for my system.

I'm using the [Colemak](https://colemak.com/) layout, so I have to change some keybindings in some programs like `tmux`, `vim`, `vscode`, etc.

## 💡 The navigation

Everything is based on _vim navigation_. Usually, you can navigate through the files with `hjkl` keys, but I've changed it for `hnei` keys. This because the Colemak layout has the `h` key in the same position, the `j` key is in the `n` position, the `k` key is in the `e` position and the `l` key is in the `i` position.

> **Note:** All the keys were mapped to the Colemak layout, this means that the `f` key (find char) is in the `t` position, the `d` key (delete char) is in the `s` position, etc.

Yep, it's a little bit confusing 🤯, but it's very useful when you're using the Colemak layout and/or you want easily switch to the `qwerty` layout.

## 📦 vim

The `vim` configuration is really basic. It contains just the basic Colemak keybindings and some general configurations.

### How to run it?

```bash
$ git clone https://github.com/mateonunez/dotfiles ~/.somewhere
$ ln -s ~/.somewhere/.vimrc ~/.vimrc
```

> Please backup your `~/.vimrc` file before running the previous command.

**Create the `swap` and `undo` directories**

```bash
$ mkdir ~/.vim/swap
$ mkdir ~/.vim/undo
```

## 📦 tmux

I really love [tmux](https://github.com/tmux/tmux), it's a great tool for managing your terminal sessions. I've created a basic configuration file for it, based on [oh-my-tmux](https://github.com/gpakosz/.tmux) and of course, with the Colemak keybindings (it uses the `vi navigation` to walk on the file).

> **Prefix key:** `Ctrl + a`

### Panel navigation

The panel navigation follows my default Colemak keybindings, so you can navigate through the panels with `hnei` keys.

- **Focus right panel:** `Ctrl + a + i`
- **Focus left panel:** `Ctrl + a + h`
- **Focus top panel:** `Ctrl + a + n`
- **Focus bottom panel:** `Ctrl + a + e`

### Panel resizing

Also, you can resize the panels with `HNEI` keys.

- **Resize to the right:** `Ctrl + a + Shift + i (or I)`
- **Resize to the left:** `Ctrl + a + Shift + h (or H)`
- **Resize to the top:** `Ctrl + a + Shift + n (or N)`
- **Resize to the bottom:** `Ctrl + a + Shift + e (or E)`

### Copy mode

The copy mode is based on the `vi navigation`, so you can navigate through the text with `hnei` keys.

**Requirements:**

- On Linux: `xclip` package and `reattach-to-user-namespace`.
- On macOS: `pbcopy` package.
- On Windows: Who knows.

> For Linux and macOS, you can install the `reattach-to-user-namespace` package with `brew install reattach-to-user-namespace` or `sudo apt install reattach-to-user-namespace` and switch to the right program in the configuration file.

To trigger the copy mode, you have to press `Ctrl + a + [`. Then, you can navigate through the text with `hnei` keys and select the text with `v` key. Once you've selected the text, you can copy it with:

- j (y in qwerty): copy to the clipboard.
- Ctrl + c: copy to the clipboard and exit the copy mode.

### How to run it?

```bash
$ git clone https://github.com/mateonunez/dotfiles ~/.somewhere
$ ln -s ~/.somewhere/.tmux.conf ~/.tmux.conf
$ ln -s ~/.somewhere/.tmux.conf.local ~/.tmux.conf.local
```

> Please backup your `~/.tmux.conf` and `~/.tmux.conf.local` files before running the previous commands.

## 📦 nvim

The `nvim` configuration is based on: [NvChad](https://nvchad.com/).

The most important thing is that the `/config/nvim/init.lua` file loads, at the end of the file, the `keymaps.vim` configuration. It's basically the same file of `.vimrc` config but without the `vim` configuration.

```lua
vim.cmd [[source ~/.config/nvim/lua/custom/keybindings.vim]]
```

> This is still a work in progress.

## 📦 vscode

The `vscode` configuration contains just the generics settings and some keybindings to improve UX.

## 📦 zsh

Generic `zsh` configuration that contains some aliases, the theme and the plugins.

## 📝 License

[MIT](MIT).
