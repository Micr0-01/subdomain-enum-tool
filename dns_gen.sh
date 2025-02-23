dnsgen ~/scripts/target/alive.txt -w ~/tools/dnscan/subdomains-500.txt | tee -a ~/scripts/target/dnsgen_subdomain.txt
cat ~/scripts/target/dnsgen_subdomain.txt | httpx -follow-redirects -silent -random-agent -retries 2  > ~/scripts/target/alive_dnsgen.txt
