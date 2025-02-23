#!/bin/bash

echo "[+]------ Starting Nuclei Project Discovery ------[+]"

# Nuclei Subdomain Scan
echo "[+] Scanning Subdomains [+]"
nuclei -l ~/scripts/target/alive.txt -t ~/nuclei-templates/ -o ~/scripts/target/nuclei_subdomains.txt
