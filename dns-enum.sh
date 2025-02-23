#!/bin/bash

# Start DNSCAN

echo "[+] Launching dnscan Subdomain Enumeration [+]"
~/tools/dnscan/dnscan.py -d $1 --recurse-wildcards -w ~/wd/dns-wordlist-large.txt -L ~/wd/resolvers.txt -o ~/scripts/target/dnscan_domains.txt 

echo "[+] Formatting the Output Results & Merging Them with domains.txt [+]"
cat ~/scripts/target/dnscan_domains.txt | sed '/A records/,$!d' | sed '1d' | cut -d - -f2 | sed 's/ //g' | sort -u | tee -a  ~/scripts/target/dns_domains.txt

echo "[+] Removing Duplicates [+]"
sort -u ~/scripts/target/dns_domains.txt -o ~/scripts/target/dns_domains.txt
rm ~/scripts/target/dnscan_domains.txt
# Start PureDNS
echo "[+] Launching PureDNS [+]"
puredns bruteforce ~/wd/best-dns-wordlist-1m.txt $1 -r ~/wd/resolvers.txt --wildcard-batch 1000000 -l 5000 -w ~/scripts/target/purednss.txt
echo "[+]Putig DNSCAN result to PureDNS [+]"
cat ~/scripts/target/dns_domains.txt | tee -a ~/scripts/target/purednss.txt
sort -u ~/scripts/target/purednss.txt -o ~/scripts/target/purednss.txt
mv ~/scripts/target/purednss.txt ~/scripts/target/dns-enum.txt
#cat ~/scripts/target/dns-enum.txt | tee -a ~/scripts/target/domains.txt
#sort -u ~/scripts/target/domains.txt -o ~/scripts/target/domains.txt
echo "[+] Done [+]"
