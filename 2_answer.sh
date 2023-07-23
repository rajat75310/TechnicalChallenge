#!/bin/bash

# Replace the placeholders with your actual Azure credentials and resource details
SUBSCRIPTION_ID="your_subscription_id"
RESOURCE_GROUP_NAME="your_resource_group_name"
RESOURCE_PROVIDER="Microsoft.Compute"
RESOURCE_TYPE="virtualMachines"
RESOURCE_NAME="your_vm_name"
SPECIFIC_KEY_NAME="your_specific_key_name"

# Authenticate using Azure CLI (you can use other authentication methods as well)
ACCESS_TOKEN=$(az account get-access-token --query accessToken --output tsv)

# API request URL to get metadata for the specified resource
API_URL="https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP_NAME/providers/$RESOURCE_PROVIDER/$RESOURCE_TYPE/$RESOURCE_NAME?api-version=2021-04-01"

# Fetch metadata using curl and jq
metadata=$(curl -s -H "Authorization: Bearer $ACCESS_TOKEN" "$API_URL" | jq -r ".properties | .[\"$SPECIFIC_KEY_NAME\"]")

echo "Value of '$SPECIFIC_KEY_NAME': $metadata"
echo "For all metadata \n "

# Fetch metadata using curl and jq
metadata2=$(curl -s -H "Authorization: Bearer $ACCESS_TOKEN" "$API_URL")
echo "Value of all Metadata of Resource $RESOURCE_NAME : $metadata2"
