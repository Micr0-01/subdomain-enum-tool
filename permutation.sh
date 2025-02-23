#!/bin/bash
echo "[+] Starting Permutations & Alterations [+]"
echo "[+] Launching Gotator [+]"
gotator -sub ~/scripts/target/domains.txt -perm ~/wd/permutation.txt -depth 1 -numbers 10 -mindup -adv -md > ~/scripts/target/gotator1.txt
echo "[+] Launching PureDNS resolver[+]"
puredns resolve ~/scripts/target/gotator1.txt -r ~/wd/resolvers.txt -w ~/scripts/target/result.permutations.txt
echo "[+] Launching DNS-Gen [+]"
dnsgen ~/scripts/target/domains.txt > ~/scripts/target/dns-gen.txt
echo "[+] Launching MassDNS [+]"
massdns -r ~/tools/massdns/lists/resolvers.txt -o S ~/scripts/target/dns-gen.txt | grep -e ' A ' | cut -d 'A' -f 1 | rev | cut -d "." -f1 --complement | rev | sort | uniq  > dnsgen_massdns_resolved.txt
echo "[+] Appending Gotator with MassDNS to one File [+]"
cat ~/scripts/target/result.permutations.txt | tee -a ~/scripts/target/dnsgen_massdns_resolved.txt
rm ~/scripts/target/result.permutations.txt
rm ~/scripts/target/gotator1.txt
rm ~/scripts/target/dns-gen.txt
mv ~/scripts/target/dnsgen_massdns_resolved.txt ~/scripts/target/permutations_resolved.txt
sort -u ~/scripts/target/permutations_resolved.txt -o ~/scripts/target/permutations_resolved.txt
#cat ~/scripts/target/permutations_resolved.txt | tee -a ~/scripts/target/domains.txt
#sort -u ~/scripts/target/domains.txt -o ~/scripts/target/domains.txt
#rm ~/scripts/target/permutations_resolved.txt
echo "[+] Done [+]"
