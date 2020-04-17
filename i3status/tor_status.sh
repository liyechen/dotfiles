if (curl --connect-timeout 10 --socks5 localhost:9050 --socks5-hostname localhost:9050 -s https://check.torproject.org/ | grep -q Congratulations); then
	echo "Tor"
	echo "#00FF00"
else
	echo "Tor"
	echo "#FF0000"
fi

