#!/bin/bash

rm ~/scripts/target/script_loader.txt

for host in `cat ~/scripts/target/alive.txt`
do
echo $host >> ~/scripts/target/script_loader.txt
curl --max-time 10 -L -i $host >> ~/scripts/target/script_loader_temp.txt
cat ~/scripts/target/script_loader_temp.txt | head -n 1 | cut -d$' ' -f2 >> ~/scripts/target/script_loader.txt
req=`curl -s -X GET -L $host/wp-admin/load-scripts.php`
req2=`curl -s -X GET -L $host | grep wordpress`
if [ -z "$req" ] && [ -n "$req2" ]
then
echo "[!] Response Body Empty [!]" >> ~/scripts/target/script_loader.txt
echo "[!] WordPress CMS Used [!] ====>>> Vulnerable" >> ~/scripts/target/script_loader.txt
fi
echo -e "" >> ~/scripts/target/script_loader.txt
rm ~/scripts/target/script_loader_temp.txt
done
