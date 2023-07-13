#!/usr/bin/env bash
# THIS IS UNFINISHED SCRIPT!!! DO NOT USE IT!!!

echo "THIS IS UNFINISHED SCRIPT!!! DO NOT USE IT!!!"
exit 1

accountid=$(aws sts get-caller-identity | jq -r '.Account')

### Security group creation

# TODO: check if these security groups already exist before creating them.

# Creating main app (GeneValidator) security group and recording its ID.
genevalidator_sg_id=$(aws ec2 create-security-group --cli-input-yaml file://AWS.YAML/EC2-Create-Security-Group-genevalidator.yaml | jq -r '.GroupId')

# Creating ingress rules allowing incoming traffic from all addresses to port 80 and 443
aws ec2 authorize-security-group-ingress --group-id $genevalidator_sg_id --cli-input-yaml file://AWS.YAML/EC2-Security-Group-rule-ingress-genevalidator.yaml

# Creating EFS mounting security group and recording its ID.
efs_sg_id=$(aws ec2 create-security-group --cli-input-yaml file://AWS.YAML/EC2-Create-Security-Group-EFS.yaml | jq -r '.GroupId')

# Creating ingress rules allowing incoming traffic from genevalidator security group addresses to port 2049 (to allow mounting NFS share)
aws ec2 authorize-security-group-ingress --group-id $efs_sg_id --source-group $genevalidator_sg_id --group-owner $accountid --port 2049 --protocol tcp

# Default all permissing egress rules are added to all security groups at creation. No need to add them manually.