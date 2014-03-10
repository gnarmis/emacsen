# Kilotau Emacs Config #

This project aims to provide configuration files and instructions to
setup Emacs as your primary editor.

## Preparation

* Assumption: You're using OSX or some *nix OS. Emacs works on almost
  everything, but you'll have to explore yourself.

* You only need three text files to make your entire Emacs
  portable and flexible: `.emacs.d/init.el`, `.emacs`, and
  `.emacs.d/Cask`.

* Symlink some files in `./emacs-config` to `$HOME`:
  - `ln -s $PWD/emacs-config/.emacs ~`
  - `ln -s $PWD/emacs-config/.emacs.d ~`
  - `ln -s $PWD/emacs-config/.emacs_zsh ~` (loads `~/.profile`,
    allowing Emacs to know your entire shell environment, if you use
    `zsh`. Bash is similar; just rename it to `.emacs_bash`).

* You now have all the configuration files setup. Time to install
  Emacs and friends.

## Emacs

* Install Emacs, of a version >= 24.0

  - On OSX: `brew install emacs`. This will install Cocoa Emacs, so
    you can run Emacs in GUI or terminal mode.

## Cask.el

- Install [Cask](http://github.com/cask/cask):

        curl -fsSkL https://raw.github.com/cask/cask/master/go | python

This is an Emacs package installation tool. It keeps your
`.emacs.d/init.el` nice and clean, and keeps your dependencies
portable without a headache.

### Emacs Keybindings for OSX

- move `./DefaultKeyBinding.dict` to `~/Library/KeyBindings/` and
  restart OSX


## Learn Basics

* Go through the Emacs tutorial.

* Know what buffers, windows, and frames mean in Emacsland.

* Know basic shortcuts (things in the tutorial)

* Learn how to use help in Emacs.

* Try working on a project entirely in Emacs, including using
  terminal inside it. Use `M-x multi-term`.
  

## Notes about this configuration

* Your `.emacs` file is where Emacs begins evaluating your
  configuration. On startup, it evaluates the contents of that file
  and thus changes the Emacs programming environment.

* In the `.emacs` file, the `.emacs.d/init.el` file is loaded. Your
  `init.el` is where the meat of the configuration happens.

* In `init.el`, you'll find the following first few lines:

        (require 'cask "~/.cask/cask.el")
        (cask-initialize)
        (require 'pallet)

  These lines setup Cask and Pallet, which together allow you to
  install packages and not worry about them being included in your
  `init.el`. You can install something and then just `(require 'foo)`
  and start using it. Also, it makes your setup portable, because all
  you need is the file `.emacs.d/Cask` and the other basic
  configuration files.

* The rest of `init.el` requires various packages, overrides defaults,
  and even defines custom functionality. The general rule is to
  clearly comment everything and organize it into logical
  sections. This helps you maintain and grow your configuration
  easily.
  

### Dependencies and Third Party Packages

* All your dependencies are defined in a file called `Cask`. You don't
  have to manually update it. To install everything defined in there,
  run `cask install` in the directory containing that file
  (`.emacs.d`).
  
* A package called Pallet allows you to just use `M-x package-install`
  to install a random package and update your `Caskfile`. This setup
  consists of a few lines at the head of your `init.el`.

