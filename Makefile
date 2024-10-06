#!/usr/bin/env bash
#coding=utf8
VIMPATH=~/.vim
VIMRC=~/.vimrc

VIM_BUNDLE=$(VIMPATH)/bundle

vim:
	@cp vimrc $(VIMRC) 
	mkdir -p $(VIMPATH)/colors && cp -r colors/ $(VIMPATH)/colors
	#install bundle 
	sudo rm -fr $(VIM_BUNDLE)
	mkdir -p $(VIMPATH)/autoload $(VIM_BUNDLE) && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	brew install ctags
	#install vim plugins
	sudo vim +BundleInstall +qall 
	#config YouCompleteMe
	#brew install cmake 
	cd $(VIM_BUNDLE)/YouCompleteMe && sudo git submodule update --init --recursive && sudo ./install.py


gitconfig:
	cp gitconfig ~/.gitconfig

