cloud_csv:
	#!/bin/sh
	# aws fastly github google-cloud microsoft-azure oracle-cloud zscaler-cloud
	cat *.json | jq -r '.prefixes[] | [.service, .scope // .region, (.ipv4Prefix // .ipv6Prefix // .ip_prefix)] | @csv' 2> /dev/null > cloud_ip_ranges.csv
	# akamai
	cat akamai*.txt | while IFS= read -r line; do echo "\"AKAMAI\",\"UNKNOWN\",$line"; done >> cloud_ip_ranges.csv
	# cloudflare
	cat cloudflare*.txt | while IFS= read -r line; do echo "\"CLOUDFLARE\",\"UNKNOWN\",$line"; done >> cloud_ip_ranges.csv
	# apple
	xsv select 2,4,1 < apple-icloud-private-relay-ip-ranges.csv | sed 's/,/-/' | while read -r line; do echo "APPLE,$line"; done > cloud_ip_ranges.csv
	# digitalocean
	xsv select 3,1 < digitalocean.csv | while read -r line; do echo "DIGITALOCEAN,$line"; done > cloud_ip_ranges.csv
	# linode
	sed '/^#/d' < linode.txt | xsv select 3,1 | while read -r line; do echo "LINODE,$line"; done > cloud_ip_ranges.csv


