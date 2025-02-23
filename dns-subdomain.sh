#!/bin/bash

# Start DNSCAN

echo "[+] Launching dnscan Subdomain Enumeration [+]"
~/tools/dnscan/dnscan.py -l ~/scripts/target/domains.txt --recurse-wildcards -w ~/tools/dnscan/subdomains-10000.txt -L ~/wd/resolvers.txt -o ~/scripts/target/dnscan_domains.txt

echo "[+] Formatting the Output Results[+]"
cat ~/scripts/target/dnscan_domains.txt | sed '/A records/,$!d' | sed '1d' | cut -d - -f2 | sed 's/ //g' | sort -u | tee -a  ~/scripts/target/dns_domains.txt

echo "[+] Removing Duplicates [+]"
sort -u ~/scripts/target/dns_domains.txt -o ~/scripts/target/dns_domains.txt
rm ~/scripts/target/dnscan_domains.txt
# Start PureDNS
echo "[+] Launching PureDNS [+]"
puredns bruteforce ~/wd/dns-wordlist-small.txt -d ~/scripts/target/domains.txt -r ~/wd/resolvers.txt --wildcard-batch 1000000 -l 5000 -w ~/scripts/target/puredns.txt
echo "[+]Putig DNSCAN result to PureDNS [+]"
cat ~/scripts/target/dns_domains.txt | tee -a ~/scripts/target/puredns.txt
sort -u ~/scripts/target/puredns.txt -o ~/scripts/target/puredns.txt
mv ~/scripts/target/puredns.txt ~/scripts/target/dns-subdomains.txt
#cat ~/scripts/target/puredns.txt | tee -a ~/scripts/target/domains.txt
#sort -u ~/scripts/target/domains.txt -o ~/scripts/target/domains.txt
echo "[+] Done [+]"
