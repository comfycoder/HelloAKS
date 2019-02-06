# Before you begin - make sure you're logged in to the azure CLI
az login

# Ensure you choose the correct azure subscription if you have more than one 
$SUBSCRIPTION_NAME = "Enter your subscription name here"

Write-Verbose "Set the default Azure subscription" -Verbose
az account set --subscription "$SUBSCRIPTION_NAME"
Write-Verbose "SUBSCRIPTION_NAME: $SUBSCRIPTION_NAME" -Verbose

$SUBSCRIPTION_ID = $(az account show --query id -o tsv)
Write-Verbose "SUBSCRIPTION_ID: $SUBSCRIPTION_ID" -Verbose

$SUBSCRIPTION_NAME = $(az account show --query name -o tsv)
Write-Verbose "SUBSCRIPTION_NAME: $SUBSCRIPTION_NAME" -Verbose

$USER_NAME = $(az account show --query user.name -o tsv)
Write-Verbose "Service Principal Name or ID: $USER_NAME" -Verbose

Write-Verbose "Get the directory when the main script is executing" -Verbose
Set-Location "C:\srcMADdotNET\HelloAKS\HelloAKS\Kubernetes"
$SCRIPT_DIRECTORY = ($pwd).path
Write-Verbose "SCRIPT_DIRECTORY: $SCRIPT_DIRECTORY" -Verbose

# Apply Variable Values
. (Join-Path $SCRIPT_DIRECTORY "variables.ps1")
