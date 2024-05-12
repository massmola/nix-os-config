#!/usr/bin/env bash

# get up to date
git pull

# Add all files to the staging area
git add .

# Commit the changes with the current date and time as the message
git commit -m "nixos switch $1: $2"

# Push the changes to the remote repository
git push

# Rebuld NixOS
sudo nixos-rebuild switch --flake ./#$1 