#!/bin/bash
echo "Gathering wayback URLS"
cat ~/scripts/target/alive.txt | waybackurls | grep "?" | uro | httpx -silent > ~/scripts/target/param.txt
echo "Lounching SQLMAP"
sqlmap -m param.txt --batch --random-agent --level 1 | tee ~/scripts/target/sqlmap.txt
