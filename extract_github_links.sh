#!/bin/bash

# Output file
OUTPUT_FILE="github_links.txt"

# Clear the output file if it exists
> "$OUTPUT_FILE"

echo "Extracting GitHub links..."

# Loop through all directories in the current folder
for dir in */; do
    # Remove trailing slash
    dir=${dir%/}
    
    # Check if the directory contains a Git repository
    if [ -d "$dir/.git" ]; then
        # Extract the origin URL
        url=$(git -C "$dir" config --get remote.origin.url)
        
        # Check if the URL is not empty and contains github.com
        if [ -n "$url" ]; then
            if [[ "$url" == *"github.com"* ]]; then
                echo "git clone $url" >> "$OUTPUT_FILE"
                echo "git clone $url"
            fi
        fi
    fi
done

echo "==================================="
echo "Done! Links have been saved to $OUTPUT_FILE"
