#!/bin/bash

# Remove square brackets and content within them from each line and create a temporary file
sed 's/\[.*\]//g' ~/scripts/target/alive.txt > ~/scripts/target/alive_cleaned.txt

# Replace the original file with the temporary file
mv ~/scripts/target/alive_cleaned.txt ~/scripts/target/alive.txt

echo "Square brackets and content removed. The original file has been updated."
