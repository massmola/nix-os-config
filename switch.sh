#!/usr/bin/env bash

# update the flake dependencies
nix flake update -f

# get up to date
git pull

# Add all files to the staging area
git add -A

# Commit the changes with the current date and time as the message
git commit -m "switch $1 at $(date): $2"

# Push the changes to the remote repository
git push

# Rebuld NixOS
sudo nixos-rebuild switch --flake ./#$1 