dotfiles
========

- [The Setup](#the-setup)
- [Installation](#installation)
- [Thanks](#thanks)

My custom way of personalizing my development environment, workflow and system.

# The Setup
- Iterm2 & Bash - shell and terminal
- Vim/NeoVim - editor
- Git - version control
- Spectacle - window management
- Other Misc tools
  - [grip](https://github.com/joeyespo/grip) - visualizes `.md` files in Github
    Flavored Markdown

All the custom configs are organized in individual folders that represent a
specific area of my overall system.

# Installation

The first thing you'll need to do is Clone the repo in your favorite location. I
like to put mine on the desktop.

```
git clone https://github.com/vinee109/dotfiles
```

The sections below will talk about how to set up each of the areas of my setup.

## Terminal

Set up the Terminal App (in this case, Iterm2):

1. Download Iterm2
2. Configure preferences to be loaded from this repo. You can do this within
   Iterm2 by navigating to `Preferences > General > Load Preferences from
   folder`

To set up all my bash aliases and configs, simply copy the `.bashrc` from this
repo into the home directory.
```
cp bash/.bashrc ~/.bashrc
```

## Vim
I use NeoVim as my preferred flavor of vim and vim-plug as my plugin manager.

### Install NeoVim

Install Neovim:
```
brew install neovim
```

### Install `python3`

Some of the plugins I use require `python3` to be available (ex: deoplete.vim).
If you don't have it you can get it through Homebrew.
```
brew install python
# or
brew upgrade python
```

Once you've downloaded python3 you should have `pip3` available. We'll use
`pip3` to download the NeoVim package, since deoplete.vim depends on it. I
recommended installing it globally so that you don't have to manage running
neovim in a virtual environment.
```
pip3 install neovim
```

To check that python3 has been installed correctly for neovim. You can run the
following within neovim.
```
:echo has('python3')
1 # if installed correctly you should get this
```

### Set up `.vimrc` and Plugins
Copy the files within the `nvim/` into the home directory
```
cp nvim/init.vim ~/.config/nvim/init.vim
cp -r nvim/.vim ~/
cp nvim/.vimrc ~/
```

Then within `nvim` you can install all the plugins defined within `.vimrc/`
```
:PlugInstall
```

## Spectacle
Copy over the preferences from this repo into the Specacle app.

```
cp spectacle/shortcuts.json ~/Library/Application\ Support/Spectacle/Shortcuts.json
```

# Thanks

Many thanks to [Manish Raghavan](https://github.com/mraghavan) for originally
introducing me to bash & vim and implementing the initial iterations of these
configs. I was using those for quite sometime before I decided to create this
repo. A good portion of this logic was inspired from Manish's original setup.
