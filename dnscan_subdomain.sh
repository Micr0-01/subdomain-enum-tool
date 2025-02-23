#!/bin/bash

# Start DNSCAN

echo "[+] Launching dnscan Subdomain Enumeration [+]"
~/tools/dnscan/dnscan.py -d $1 -w ~/tools/dnscan/subdomains-10000.txt -o ~/scripts/target/dnscan_domains.txt

echo "[+] Formatting the Output Results & Merging Them with domains.txt [+]"
cat ~/scripts/target/dnscan_domains.txt | sed '/A records/,$!d' | sed '1d' | cut -d - -f2 | sed 's/ //g' | sort -u | tee -a  ~/scripts/target/domains.txt

echo "[+] Removing Duplicates [+]"
sort -u ~/scripts/target/domains.txt -o ~/scripts/target/domains.txt
