#!/bin/sh
#################################################
# Author: Khanh Pham                            #
# Date: 16 Sep 2021                             #
# Description: Check out all Azure DevOps repos #
#################################################

### Installation required packages #####
# - aws-cli
# - jq

### Functions
check_cmd() {
    ## Check az-cli command
    which az >/dev/null;
    if [ $? -eq 1 ]; then
        echo "!!! Need to install az-cli command"
        echo "https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
        exit 1
    fi
    which jq >/dev/null;
    ## Check JSON Processor command
    if [ $? -eq 1 ]; then
        echo "!!! Need to install jq command"
        echo "https://stedolan.github.io/jq/download/"
        exit 1
    fi
    az account show >/dev/null 
    ## Check Az login
    if [ $? -eq 1 ]; then
        echo "!!! Need to login"
        az login
    fi
}
######################### Main Script ####################
### Check required commands
check_cmd

### Variables
az login
Repos=`az repos list | jq -r .[].remoteUrl`

for rpn in $Repos
do
	echo $rpn
    git clone $rpn
done
