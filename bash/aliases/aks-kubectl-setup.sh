
function setup-kubeconfig(){
	kubeconfig=~/.kube/config
	touch $kubeconfig
	containerId=$(docker container run --rm -d -it -v $kubeconfig:/root/.kube/config mcr.microsoft.com/azure-cli)
# this only works for accounts without two-factor auth	
# read -sp "Azure Password: " AZ_PASS && echo && 
# docker exec -it $containerId az login -u christian.cadruvi -p $AZ_PASS
	docker exec -it $containerId az login
	docker exec -it $containerId az aks get-credentials --resource-group Kubernetes-Test --name k8s-tesk8s004 --subscription 1f528d4c-510c-40ed-b8e2-3865dd80f12c
	docker rm -f $containerId
}
