#use htop instead of top
if [ -e /usr/bin/htop ]
then
	alias top='htop'
fi
