echo "[+] Formatting JS Files [+]"
cat $1 | cut -d " " -f 3 > target/jsformatted.txt
