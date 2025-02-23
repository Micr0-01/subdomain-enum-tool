#!/bin/bash
echo "[+] Launching Fast Port Scan [+]"
naabu -iL ~/scripts/target/domains.txt -v -p - -exclude-ports 80,443 -json -o ~/scripts/target/domains_ip
