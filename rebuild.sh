#!/usr/bin/env bash

set -e

git pull

gen=$(nixos-rebuild list-generations | grep current)
# Add all files to the staging area
git add -A
# Commit the changes with the current date and time as the message
git commit -m "switch $1: $2, $gen"

sudo nixos-rebuild switch --flake ./#$1 

# Rebuld NixOS

# Push the changes to the remote repository
git push