#!/bin/bash
echo "[+] Launching analyticsrelationships Subdomain Enumeration [+]"
cat ~/scripts/target/alive.txt | analyticsrelationships -ch  > ~/scripts/target/analytics.txt
echo "[+] Removing Duplicates And Extra Trashes [+]"
cat ~/scripts/target/analytics.txt | unfurl -u domains | tee -a ~/scripts/target/analytics.txt
echo "[+] Done [+]"
