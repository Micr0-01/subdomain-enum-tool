echo "[+]------ Starting Content Discovery ------[+]"

dirsearch --url $1 -w ~/wd/directories-2m-300k.txt -t 50 --timeout 3 -x 403,500,507,508,404,405,503  -e js,php,bak,txt,asp,aspx,jsp,html,zip,jar,sql,json,old,gz,shtml,log,swp,yaml,yml,c --random-agent --deep-recursive --force-recursive -o ~/scripts/target/content-discovery.txt

# echo "[+] Removing Trash Files [+]"
rm -r ~/tools/dirsearch/reports/*
