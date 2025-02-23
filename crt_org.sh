#!/bin/bash
# Usage Input Example: Snap+Inc.
echo "[+] Scrap Subdomains by Organization Name From CRT.SH[+]"
curl 'https://crt.sh/?o=%.'$1'&output=json' | jq -r '.[].common_name' | grep -v '*' | sort | uniq | tee -a ~/scripts/target/domainsOrg.txt
