#!/usr/bin/env bash

set -e
gen=$(nixos-rebuild list-generations | grep current)

# Add all files to the staging area
# Commit the changes with the current date and time as the message
git add -A
git commit -m "switch $1: $2, $gen"
git pull

# Rebuld NixOS
sudo nixos-rebuild switch --extra-experimental-features --flake ./#$1  

# Push the changes to the remote repository
git push