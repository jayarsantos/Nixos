#!/bin/sh
pushd ~/.dotfiles
home-manager build --flake .#jayar@jaynix
popd
