echo "[+]Searching For Parameter In Wayback Machine[+]"
 paramspider -d $1

echo "[+]Lounching openredirex[+]"
cat ~/scripts/target/results/$1.txt | openredirex -p ~/tools/openredirex/open.txt --keyword FUZZ -c 20 |  tee -a ~/scripts/target/open_redirect.txt

echo "[+]Done[+]"
