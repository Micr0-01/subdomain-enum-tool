echo "[+]------ Starting Content Discovery ------[+]"

#Content Discovery via Dirsearch
echo "[+] Content Disccovery in Porcess [+]"
python3 ~/tools/dirsearch/dirsearch.py -l ~/scripts/target/alive.txt -e js,php,bak,txt,asp,aspx,jsp,html,zip,jar,sql,json,old,gz,shtml,log,swp,yaml,yml,config,save,rsa,ppk,tar,xlsx,ppt,pdf -t 50 --timeout 3 -x 403,500,507,508 --full-url --plain-text-report=ContentDiscovery
mv ContentDiscovery ~/scripts/target/ContentDiscovery.txt

#echo "[+] Removing Trash Files [+]"
rm -r ~/tools/dirsearch/reports/*
