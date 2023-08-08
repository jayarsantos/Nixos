#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/jayar/home.nix
popd
