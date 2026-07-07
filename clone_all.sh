#!/bin/bash

# File containing the git clone commands
INPUT_FILE="/home/x/Work/github_links.txt"

# Check if the file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: $INPUT_FILE not found!"
    exit 1
fi

echo "Starting to clone projects from $INPUT_FILE..."

# Read the file line by line
while IFS= read -r cmd; do
    # Skip empty lines
    if [ -z "$cmd" ]; then
        continue
    fi
    
    echo "Executing: $cmd"
    # Execute the command (git clone ...)
    eval "$cmd"
    
done < "$INPUT_FILE"

echo "==================================="
echo "All projects have been cloned successfully!"
