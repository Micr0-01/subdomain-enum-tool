#!/bin/bash

echo "[+]------ Starting Subdomain Enumeration ------[+]"

#starting sublist3r
echo "[+] Starting Sublist3r [+]"
~/tools/Sublist3r/sublist3r.py -d $1 -v -o ~/scripts/target/domains.txt

#starting subfinder
echo "[+] Starting SubFinder [+]"
subfinder -d $1 -o ~/scripts/target/domains2.txt

#Appending domains2 to domains
cat ~/scripts/target/domains2.txt | tee -a ~/scripts/target/domains.txt

#running assetfinder
echo "[+] Starting Assetfinder [+]"
assetfinder --subs-only $1 | tee -a ~/scripts/target/domains.txt

echo "[+] Starting Findomain [+]"
findomain -t $1 -u ~/scripts/target/find.txt

#Appending find.txt to domains.txt
cat ~/scripts/target/find.txt | tee -a ~/scripts/target/domains.txt

#starting crt.sh
echo "[+] Starting crt.sh [+]"
~/scripts/Crt.sh $1
cat ~/scripts/target/rabar.txt | tee -a ~/scripts/target/domains.txt
echo "[+] Starting gau [+]"
gau --threads 5 --subs $1 |  unfurl -u domains | sort -u -o ~/scripts/target/gau.txt

echo "[+] Starting waybackurls [+]"
waybackurls $1 | unfurl -u domains | sort -u -o ~/scripts/target/waybackd.txt

echo "[+] Starting github-subdomains [+]"
github-subdomains -d $1 -t ~/.config/github-subdomains/token.txt -o ~/scripts/target/github.txt

#removing duplicate entries
echo "[+] Removing Duplicates [+]"
cat  ~/scripts/target/gau.txt | tee -a ~/scripts/target/domains.txt
cat  ~/scripts/target/waybackd.txt | tee -a ~/scripts/target/domains.txt
cat  ~/scripts/target/github.txt | tee -a ~/scripts/target/domains.txt
sort -u ~/scripts/target/domains.txt -o ~/scripts/target/domains.txt
rm ~/scripts/target/find.txt
rm ~/scripts/target/domains2.txt
rm  ~/scripts/target/gau.txt
rm ~/scripts/target/waybackd.txt
rm ~/scripts/target/github.txt
rm ~/scripts/target/rabar.txt
#checking for alive domains
echo "[+] Checking for alive domains.. [+]"
cat ~/scripts/target/domains.txt | httpx -follow-redirects -silent > ~/scripts/target/alive.txt

echo "[+] Launching TLS Enumeration [+]"
cat ~/scripts/target/domains.txt | cero -c 1000 > ~/scripts/target/tls.txt

echo "[+] Launching CSP Enumeration [+]"
cat ~/scripts/target/domains.txt | httpx -csp-probe -status-code -retries 2 -no-color | anew ~/scripts/target/csp_probed.txt | cut -d ' ' -f1 | unfurl -u domains | anew -q ~/scripts/target/csp_subdomains.txt

echo "[+] Launching CNAME Enumeration [+]"
dnsx -retry 3 -cname -l cat ~/scripts/target/domains.txt | tee -a ~/scripts/target/cname.txt

echo "[+] Removing Duplicate [+]"
cat ~/scripts/target/tls.txt | tee -a ~/scripts/target/csp_probed.txt
cat ~/scripts/target/csp_subdomains.txt | tee -a ~/scripts/target/cname.txt
sort -u ~/scripts/target/cname.txt -o ~/scripts/target/cname.txt
mv ~/scripts/target/cname.txt ~/scripts/target/cname-tls-csp.txt
rm ~/scripts/target/tls.txt
rm ~/scripts/target/csp_subdomains.txt
rm ~/scripts/target/csp_probed.txt
#cat ~/scripts/target/cname-tls-csp.txt | tee -a ~/scripts/target/domains.txt
#sort -u ~/scripts/target/domains.txt -o ~/scripts/target/domains.txt
#rm ~/scripts/target/cname-tls-csp.txt

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

#running amass
#echo "[+] Starting Amass Passive Mode [+]"
#- Passive mode
#amass enum --passive -d $1
#amass enum -passive -d $1 -config ~/.config/amass/datasources.yaml
#echo "[+] Starting Amass BruteForce Mode [+]"
#- Bruteforce Verbose mode
#amass enum -brute -d $1 -v
#echo "[+] Starting Reverse Whois [+]"
#amass intel -whois -d $1
#echo "[+] Output the result & Merging with domains.txt [+]"
#oam_subs -names -d $1 -o ~/scripts/target/amass.txt
#cat ~/scripts/target/amass.txt | tee -a ~/scripts/target/domains.txt
#sort -u ~/scripts/target/domains.txt -o ~/scripts/target/domains.txt
#rm ~/scripts/target/amass.txt
#echo "[+] Done [+]"
