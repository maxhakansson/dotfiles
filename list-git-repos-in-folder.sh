#!/bin/bash

# Change directory to the parent folder containing your Git repositories
cd ~/git

# Loop through all subfolders
for dir in */; do
    # Check if the subfolder is a Git repository
    if [ -d "$dir/.git" ]; then
        # Get the remote URL of the Git repository
        remote_url=$(git -C "$dir" config --get remote.origin.url)
        if [ -n "$remote_url" ]; then
            echo "$remote_url"
        else
            echo "Git repository in $dir does not have a remote URL configured."
        fi
    fi
done
