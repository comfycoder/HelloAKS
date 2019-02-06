
# Get the ACR resource id using az acr show
$ACR_RESOURCE_ID = az acr show -g $RESOURCE_GROUP -n $REGISTRY_NAME --query "id" --output tsv
Write-Verbose "ACR_RESOURCE_ID: $ACR_RESOURCE_ID" -Verbose

# Run the following to create a role assignment using the az role assignment create command
# az role assignment create --assignee $AKS_RESOURCE_ID --scope $ACR_RESOURCE_ID --role Reader

Set-Location "C:\srcMADdotNET\HelloAKS\HelloAKS"

# Build a docker image from the dockerfile:
docker build -t $IMAGE_NAME -f "./Dockerfile" --label "author=Dennis Moon" .

# Run the image:
docker run -d -p 8080:80 $IMAGE_NAME –name $CONTAINER_NAME

# Test the containerized application is working:
Start-Process http://localhost:8080

# Show running containers
docker ps

# Show all containers
docker ps -a

# Stop all containers
docker stop $(docker ps -aq)

# Remove all containers
docker rm $(docker ps -aq)

# List all images
docker images

# Log into our container registry
az acr login -n $REGISTRY_NAME

# Get the login server name
$LOGIN_SERVER = az acr show -n $REGISTRY_NAME --query loginServer --output tsv
Write-Verbose "RESOURCE_GROUP: $LOGIN_SERVER" -Verbose

# See the images we have - should have helloaks:v1
docker image ls

# Give the image a new tag that includes the Azure Container Registry name
docker tag $IMAGE_NAME $LOGIN_SERVER/$IMAGE_NAME

# See the images we have - should have helloaks:v1
docker image ls

# Push the image to our Azure Container Registry
docker push $LOGIN_SERVER/$IMAGE_NAME

# View the images in our ACR
az acr repository list -n $REGISTRY_NAME -o table

# view the tags for the samplewebapp repository
az acr repository show-tags -n $REGISTRY_NAME --repository helloaks -o table

# Check we have kubectl (should have if we've installed docker for windows)
kubectl version --short

# Get the credentials for your cluster 
az aks get-credentials -g $RESOURCE_GROUP -n $CLUSTER_NAME

# n.b. if the dashboard shows errors, you may need this fix:
# https://pascalnaber.wordpress.com/2018/06/17/access-dashboard-on-aks-with-rbac-enabled/
# kubectl create clusterrolebinding kubernetes-dashboard -n kube-system --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard
# Must use Ctrl+C to exit from command line

# Open the Kubernetes dashboard
az aks browse -g $RESOURCE_GROUP -n $CLUSTER_NAME

# Check we're connected (Ctrl+C if this hangs more than a few seconds)
kubectl get nodes

# Get the version of Kubernetes running in your AKS cluster
az aks show -g $RESOURCE_GROUP -n $CLUSTER_NAME --query kubernetesVersion

# Set the path to the aks deployment file
$APP_DEPLOY_FILE = (Join-Path $SCRIPT_DIRECTORY "k8s-deploy-app.yaml")
Write-Verbose "APP_DEPLOY_FILE: $APP_DEPLOY_FILE" -Verbose

# Deploy the app
kubectl apply -f "$APP_DEPLOY_FILE"

# Check the status of the pods
kubectl get pods

# Check description of the pod status
kubectl get pod "Put Pod Name Here"

# get list of services running in AKS
kubectl get services

# Find out where it is (IP Address)
kubectl get service "$AKS_APP_NAME" --watch

# Get service configuration as json
kubectl get service "$AKS_APP_NAME" -o json

# Get service configuration as json
$SERVICE_IP = kubectl get service "$AKS_APP_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
Write-Verbose "SERVICE_IP: $SERVICE_IP" -Verbose

# Test the containerized application is working:
Start-Process "http://$SERVICE_IP"
