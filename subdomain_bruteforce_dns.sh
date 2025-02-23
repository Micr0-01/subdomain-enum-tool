#!/bin/bash

# Start DNSCAN

echo "[+] Launching dnscan Subdomain Enumeration [+]"
~/tools/dnscan/dnscan.py -d $1 -w ~/wd/subdomain649k.txt -o ~/scripts/target/dnscan_domains.txt -i ~/scripts/target/dnscan_ip.txt

echo "[+] Formatting the Output Results & Merging Them with domains.txt [+]"
cat ~/scripts/target/dnscan_domains.txt | sed '/A records/,$!d' | sed '1d' | cut -d - -f2 | sed 's/ //g' | sort -u | tee -a  ~/scripts/target/$1.txt
echo "[+] Removing Duplicates [+]"
sort -u ~/scripts/target/domains.txt -o ~/scripts/target/$1.txt
