#use htop instead of top
if [ -e /usr/bin/htop ]
then
	alias top='htop'
fi

kc(){
	echo "Namespace set to $1"
	kubectl config set-context $(gcloud container clusters list --format="value(name)") --namespace "$1"
}
