#!/bin/bash

# Subdomain Enumeration Automation
~/scripts/enumlivesub.sh $1

# Subdomain Takeover Automation
~/scripts/subdomaintakeover.sh

# Wayback Automation
~/scripts/waybackext.sh $1 $2

# Web Screenshot Automation
~/scripts/webscreenshot.sh

# Nuclei Automation
~/scripts/nuclei.sh
