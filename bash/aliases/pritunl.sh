function pritunl(){
	sudo bash -c 'pritunl-client-service & > /dev/null 2>&1' > /dev/null 2>&1
	sleep 2
	sudo bash -c 'pritunl-client-electron --no-sandbox & > /dev/null 2>&1' > /dev/null 2>&1
}
