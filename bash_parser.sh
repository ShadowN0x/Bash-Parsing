#!/bin/bash
# Bash Parser - Take a list of given URLs, perform a WPscan on each, and store the output into separate files for later review.

# Banner Art
banner="
 ▄▄▄▄    ▄▄▄        ██████  ██░ ██     ██▓███   ▄▄▄       ██▀███    ██████ ▓█████  ██▀███
▓█████▄ ▒████▄    ▒██    ▒ ▓██░ ██▒   ▓██░  ██▒▒████▄    ▓██ ▒ ██▒▒██    ▒ ▓█   ▀ ▓██ ▒ ██▒
▒██▒ ▄██▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░   ▓██░ ██▓▒▒██  ▀█▄  ▓██ ░▄█ ▒░ ▓██▄   ▒███   ▓██ ░▄█ ▒
▒██░█▀  ░██▄▄▄▄██   ▒   ██▒░▓█ ░██    ▒██▄█▓▒ ▒░██▄▄▄▄██ ▒██▀▀█▄    ▒   ██▒▒▓█  ▄ ▒██▀▀█▄
░▓█  ▀█▓ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓   ▒██▒ ░  ░ ▓█   ▓██▒░██▓ ▒██▒▒██████▒▒░▒████▒░██▓ ▒██▒
░▒▓███▀▒ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒   ▒▓▒░ ░  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░▒ ▒▓▒ ▒ ░░░ ▒░ ░░ ▒▓ ░▒▓░
▒░▒   ░   ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░   ░▒ ░       ▒   ▒▒ ░  ░▒ ░ ▒░░ ░▒  ░ ░ ░ ░  ░  ░▒ ░ ▒░
 ░    ░   ░   ▒   ░  ░  ░   ░  ░░ ░   ░░         ░   ▒     ░░   ░ ░  ░  ░     ░     ░░   ░
 ░            ░  ░      ░   ░  ░  ░                  ░  ░   ░           ░     ░  ░   ░
"

echo "$banner"

# ANSI color codes
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Check if the input file with URLs exists
if [ ! -f "urls.txt" ]; then
  echo "The file 'urls.txt' does not exist. Please create it and add your target URLs."
  exit 1
fi

# Create the Results folder if it doesn't exist
mkdir -p Results

# Loop through each URL from the urls.txt file
while IFS= read -r url; do

# Generate a filename based on the URL from the urls.txt file -- Replace non-alphanumeric chars with underscore
filename=$(echo "$url" | sed 's/[^a-zA-Z0-9]/_/g').txt

echo -e "${BLUE}Running wpscan for $url...${NC}"

# Run wpscan and save the output to the corresponding text file inside the Results folder
wpscan --url "$url" > "Results/$filename.txt" 2>&1

echo -e "${GREEN}Results saved to Results/$filename.txt${NC}"
done < "urls.txt"

echo "All Target URLs Scanned. Check 'Results' Folder to Review."   
