#!/usr/bin/env bash

set -e

# Parse arguments to extract --update
args=()
update=false
for arg in "$@"; do
    if [ "$arg" == "--update" ]; then
        update=true
    else
        args+=("$arg")
    fi
done

# Restore positional parameters without --update
set -- "${args[@]}"

# Update flake if requested
if [ "$update" = true ]; then
    echo "Updating flake..."
    nix flake update
fi

gen=$(nix-env --list-generations | awk '/current/ {print}')

# Check if the user has provided a commit message
if [ -z "$1" ]; then
    echo "No commit message provided. Using default message."
    set -- "No message provided" "$2"
fi

# Check if the user has provided a issue number
if [ ! -z "$2" ]; then
    echo "No issue number provided. not linking commit to an issue."
    set -- "$1" " #$2"
else
    # If no second argument, just use the first argument as is
    set -- "$1" ""
fi

# Add all files to the staging area
# Commit the changes with the current date and time as the message
git add -A
git commit -m "switch marvin$2: $1, $gen"
git pull

# Rebuld NixOS
sudo nixos-rebuild switch --flake ./#marvin

# Push the changes to the remote repository
git push