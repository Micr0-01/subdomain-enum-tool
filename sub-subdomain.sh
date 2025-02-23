#!/bin/bash

echo "[+]------ Starting Sub-Subdomains Enumeration ------[+]"

# Collecting sub-subdomains
echo "[+] Enumerating Sub-Subdomains [+]"
altdns -i ~/scripts/target/alive.txt -o data_output -w ~/tools/altdns/words.txt -r -s ~/scripts/target/sub-subdomains.txt

echo "[+] Removing Trash Files [+]"
rm data_output

echo "[+] Extracting Only Subdomains [+]"

filename="/home/eleven001/scripts/target/sub-subdomains.txt"
output_file="/home/eleven001/scripts/target/sub_subdomains.txt"

# Extract the subdomains using awk
subdomains=$( awk '{split($1,a,":"); print a[1]}' "$filename" > "$output_file")
# Print the extracted subdomains
for subdomain in $subdomains; do
    echo "$subdomain"
done

# Remove the original file
rm "$filename"
