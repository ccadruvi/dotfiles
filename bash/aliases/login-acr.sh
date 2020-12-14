
function acr-login(){
        containerId=$(docker container run --rm -d -it mcr.microsoft.com/azure-cli)
# this only works for accounts without two-factor auth
# read -sp "Azure Password: " AZ_PASS && echo && 
# docker exec -it $containerId az login -u christian.cadruvi -p $AZ_PASS
        docker exec -it $containerId az login
        docker exec -it $containerId az acr  login --name anymodconrst001dg --expose-token
        docker rm -f $containerId
	docker login -u 00000000-0000-0000-0000-000000000000  anymodconrst001dg.azurecr.io
}

