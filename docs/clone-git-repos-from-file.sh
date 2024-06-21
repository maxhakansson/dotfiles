#!/bin/bash

# Define the name of the text file containing repository URLs
input_file="./git-repos.txt"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "Error: The input file '$input_file' does not exist."
  exit 1
fi

# Loop through the lines in the input file and clone each repository
while IFS= read -r repo_url; do
  # Clone the repository into the current folder
  git clone "$repo_url"
done < "$input_file"

echo "All repositories have been cloned."
