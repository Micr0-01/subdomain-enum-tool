#!/bin/bash
#running amass
echo "[+] Starting Amass Passive Mode [+]"
#- Passive mode
amass enum --passive -d $1
amass enum -passive -d $1 -config ~/.config/amass/datasources.yaml
echo "[+] Starting Amass BruteForce Mode [+]"
#- Bruteforce Verbose mode
amass enum -brute -d $1 -v
echo "[+] Starting Reverse Whois [+]"
amass intel -whois -d $1
echo "[+] Output the result & Merging with domains.txt [+]"
oam_subs -names -d $1 -o ~/scripts/target/amass.txt
cat ~/scripts/target/amass.txt | tee -a ~/scripts/target/domains.txt
sort -u ~/scripts/target/domains.txt -o ~/scripts/target/domains.txt
rm ~/scripts/target/amass.txt
echo "[+] Done [+]"
