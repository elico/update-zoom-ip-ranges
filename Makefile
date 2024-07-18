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
