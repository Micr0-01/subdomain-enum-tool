#!/bin/bash
#!/bin/bash

echo "[+]------ Starting Source Code Enumeration ------[+]"
gospider -S ~/scripts/target/alive.txt --js -d 3 --sitemap --robots -w -r | tee -a ~/scripts/target/gospider-domain.txt

echo "[+] Cleaning the output [+]"
sed -i '/^.\{2048\}./d' ~/scripts/target/gospider-domain.txt
cat ~/scripts/target/gospider-domain.txt | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | grep ".example.com$" | sort -u ~/scripts/target/gospider-domain.txt -o ~/scripts/target/source-code-domains.txt
cat ~/scripts/target/source-code-domains.txt | awk -F ' - ' '/https:\/\// {print $NF}' | unfurl -u domains | tee -a ~/scripts/target/source-code-domains.txt
sort -u ~/scripts/target/source-code-domains.txt -o ~/scripts/target/source-code-domains.txt
rm ~/scripts/target/gospider-domain.txt
echo "[+] Resolving [+]"
puredns resolve ~/scripts/target/source-code-domains.txt -w ~/scripts/target/source-resolved.txt -r ~/wd/resolvers.txt
echo "[+] Removing duplicate [+]"
sort -u ~/scripts/target/source-resolved.txt -o ~/scripts/target/source-resolved.txt
mv ~/scripts/target/source-resolved.txt ~/scripts/target/source-code-resolved.txt
rm ~/scripts/target/source-code-domains.txt
#cat ~/scripts/target/source-resolved.txt | tee -a ~/scripts/target/domains.txt
#sort -u ~/scripts/target/domains.txt -o ~/scripts/target/domains.txt
#rm ~/scripts/target/source-resolved.txt
