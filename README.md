dotfiles
========

My custom way of personalizing up my development environment, workflow and system.

# Areas
All the custom configs are organized in individual folders that represent a
specific area of my overall system.

Core Areas:
- Shell (Bash, Iterm2 as terminal application)
- NeoVim
- Spectacle
- Git

# Installation

## Spectacle

```
mv spectacle/shortcuts.json ~/Library/Application\ Support/Spectacle/Shortcuts.json
```

## Iterm
Use Preferences > General > Load Preferences from folder

# Misc

## pandoc

Used primarily for converting Markdown to HTML. The HTML is viewed in the
browser during development to ensure that the Markdown is correct.

Installation:
```
brew install pandoc
```

# Thanks
Many thanks to [Manish Raghavan](https://github.com/mraghavan) for originally
introducing me to bash & vim and implementing the initial iterations of these
configs. I was using those for quite sometime before I decided to create this
repo. A good portion of this logic was inspired from Manish's original setup.
