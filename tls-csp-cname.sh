#!/bin/bash
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
