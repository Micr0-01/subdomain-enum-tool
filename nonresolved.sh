#!/bin/bash

echo "[+] Extracting Non Resolved Domains [+]"

for domain in `cat ~/scripts/target/domains.txt`
do
if ! cat ~/scripts/target/alive.txt | grep -oP 'https://\K\S+|http://\K\S+' | grep -Fx ${domain}
then
echo $domain >> ~/scripts/target/nonresolved.txt
fi
done
