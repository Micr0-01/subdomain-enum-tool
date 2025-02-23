#!/bin/bash

#Resolving hosts
echo "[+] Resolving Hosts/Domains [+]"
for host in `cat ~/scripts/target/domains.txt`
do
dig +short $host >> ~/scripts/target/ip_address.txt
done

#removing duplicate entries
echo "[+] Removing Duplicates [+]"
sort -u ~/scripts/target/ip_address.txt -o ~/scripts/target/ip_address.txt

# Port & Services Scanning
echo "[+] Start Port and Services Scanning [+]"
nmap -iL ~/scripts/target/ip_address.txt -sV -oN ~/scripts/target/port_services_scan.txt
