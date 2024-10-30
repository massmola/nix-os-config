#!/usr/bin/env bash

set -e

gen=$(nixos-rebuild list-generations | grep current)

# Add all files to the staging area
# Commit the changes with the current date and time as the message
git add -A
git commit -m "switch marvin, #$2: $1, $gen"
git pull

# Rebuld NixOS
sudo nixos-rebuild switch --flake ./#marvin

# Push the changes to the remote repository
git push