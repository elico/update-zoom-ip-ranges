all:
	echo OK

download-all:
	bash download-links.sh

collect-addresses:
	bash collect-ipv4.sh
	bash collect-ipv6.sh

deploy-lists:
	echo "Deploying to..."
#	cp -vf zoom-ipv4.list ..
#	cp -vf zoom-ipv6.list ..

generate-routeros-lists:
	bash gen-rsc-from-list.sh v4 zoom-ipv4.list zoom-ipv4.rsc zoom.us	
	bash gen-rsc-from-list.sh v6 zoom-ipv6.list zoom-ipv6.rsc zoom.us
