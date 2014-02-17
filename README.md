# Kilotau Emacs Config #

This project aims to provide configuration files and instructions to
setup Emacs as your primary editor.

## Preparation

* Install Cask, an emacs package installation tool. It greatly
  simplifies your configuration and helps you declaratively define the
  dependencies of your Emacs setup.

## Emacs

* Install Emacs, of a version >= 24.0

  - On OSX: `brew install emacs`. This will install Cocoa Emacs, so
    you can run Emacs in GUI or terminal mode.

## Cask.el

- Install [Cask](http://github.com/cask/cask):

        curl -fsSkL https://raw.github.com/cask/cask/master/go | python


## Setup Emacs

- Copy, or better yet symlink, the `.emacs` file and the `.emacs.d`
  directory to your home directory.

- Inside your `.emacs.d` directory:

        cask install

### Emacs Keybindings for OSX

- move `./DefaultKeyBinding.dict` to `~/Library/KeyBindings/` and restart


## Learn Basics

* Go through the Emacs tutorial.

* Know what buffers, windows, and frames mean in Emacsland.

* Know basic shortcuts (things in the tutorial)

* Learn how to use help in Emacs.

* Try working on a project entirely in Emacs, including using
  terminal inside it.
  

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

