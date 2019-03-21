#use htop instead of top
if [ -e /usr/bin/htop ]
then
	alias top='htop'
fi

sp(){
	gcloud config set project "$1"
	gcloud container clusters get-credentials cluster
}

kc(){
	echo "Namespace set to $1"
	gcloud container clusters get-credentials cluster -z europe-west4-b
	kubectl config set-context $(gcloud container clusters list --format="value(name)") --namespace "$1"
	kubectl config set-context $(kubectl config current-context) --namespace="$1"
}
