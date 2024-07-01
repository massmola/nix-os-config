#!/usr/bin/env bash

# update the flake dependencies
nix flake update

# get up to date
git pull

# Add all files to the staging area
git add .

# Commit the changes with the current date and time as the message
<<<<<<< HEAD
git commit -m "nixos switch $1: $2"
=======
git commit -m "switch osconfig: $(date)"
>>>>>>> b341879 (test nix: ven 3 mag 2024, 12:49:22, CEST)

# Push the changes to the remote repository
git push

# Rebuld NixOS
sudo nixos-rebuild switch --flake ./#$1 