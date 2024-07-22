#!/usr/bin/env bash

set -e
gen=$(nixos-rebuild list-generations | grep current)

git add -A
git commit -m "switch $1: $2, $gen"
git pull

# Add all files to the staging area
# Commit the changes with the current date and time as the message

sudo nixos-rebuild switch --flake ./#$1 

# Rebuld NixOS

# Push the changes to the remote repository
git push