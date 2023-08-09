#!/bin/sh
pushd ~/.dotfiles
home-manager switch --flake .#jayar@jaynix
popd
