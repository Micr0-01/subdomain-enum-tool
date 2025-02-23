#!/bin/bash

for host in `cat ~/scripts/target/alive.txt`
do
echo "[+] Scraping wordlist from $host [+]"
~/tools/CeWL/cewl.rb $host >> ~/scripts/target/cewl_wordlist.txt
done

echo "[+] Removing Duplicates [+]"
sort -u ~/scripts/target/cewl_wordlist.txt -o ~/scripts/target/cewl_wordlist.txt
