# Set variable values
$RESOURCE_GROUP = "RG-CN-MADdotNET-AKS"
Write-Verbose "RESOURCE_GROUP: $RESOURCE_GROUP" -Verbose

$CLUSTER_NAME = "AKS-CN-MADdotNET"
Write-Verbose "CLUSTER_NAME: $CLUSTER_NAME" -Verbose

$REGISTRY_NAME = "acrcnea2maddotnet"
Write-Verbose "REGISTRY_NAME: $REGISTRY_NAME" -Verbose

$IMAGE_NAME = "helloaks:v1"
Write-Verbose "IMAGE_NAME: $IMAGE_NAME" -Verbose

$CONTAINER_NAME = "helloaks"
Write-Verbose "CONTAINER_NAME: $CONTAINER_NAME" -Verbose

$AKS_APP_NAME = "hello-aks-demo"
Write-Verbose "AKS_APP_NAME: $AKS_APP_NAME" -Verbose

$AKS_RESOURCE_ID = "Enter AKS SP App ID Guid Here..."
Write-Verbose "AKS_RESOURCE_ID: $AKS_RESOURCE_ID" -Verbose