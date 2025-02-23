#!/bin/bash

echo "[+]------ Starting JS Files Enumeration ------[+]"

# Extract JS Files
echo "[+] Extracting JS Files [+]"
cat ~/scripts/target/alive.txt | getJS --complete --resolve --output ~/scripts/target/jsfiles.txt

# Extracting Urls from JS Files
echo "[+] Extracting Urls/Endpoints From JS Fiels [+]"
while read -r line; do
echo "+ " + $line + " :" >> ~/scripts/target/urlsextract.txt
echo $line | ~/tools/relative-url-extractor/extract.rb >> ~/scripts/target/urlsextract.txt
done < ~/scripts/target/jsfiles.txt

# Extracting Urls/Endoints from Websites
echo "[+] Extracting Urls/Endpoint From Websites [+]"
while read -r line; do
echo "+ $line ::" >> ~/scripts/target/urlsextract.txt
curl -s $line | ~/tools/relative-url-extractor/extract.rb >> ~/scripts/target/urlsextract.txt
done < ~/scripts/target/alive.txt
