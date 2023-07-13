# Running GeneValidator in AWS Elastic Container Service using HTTP only (no SSL)

This is yet unfinished document. A simple list of actions to be done is the following
- Create security groups for genevalidator and for EFS access
- Create target group
- Create load balancer
- Create load balancer rule to forward port 80 to the target group
- (optional) Create Route 53 hostname record to associate with DNS record of load balancer.
- Create ECR registry
- Using Docker files build all necessary images (gv, nginx, [certbot])
- Push images there
- Upload all necessary files to EFS
- Create Task definition for genevalidator and for certbot
- Create ECS Cluster (???)
- Create ECS Service (including Load Balancer attachment and auto scaling)

In case HTTPS, you also need to
- Create certificate in AWS Certificate manager
- Create role and user which can import certificates in certificate manager
- For new user generate access keys and add create credentials and config for aws access on EFS
- run manually certbot to allow it to generate certificates
- change add HTTPS rule to forward to target group and HTTP rule to redirect to HTTPS
- Create ECS Cluster Scheduler to run Certbot periodically.

## Prerequisites

You need to have AWS account and user which has the role allowing to manipulate (create, modify, delete) with Elastic Load Balancers (incl Target Groups), Security groups, Elastic Container Registry, Elastic Container Service (incl. ECS Cluster, Task Definitions, ECS Services). For HTTPS setup, you also need access to AWS Certificate Manager to be able to create and import certificates, be able to create roles and users in AWS Identity Manager (to give access to ACM to import certificates).local_https_challenge

You should already have Elastic File System volume and VPC with subnets for the region where you are going to build your infrastructure.

You should be able to run AWS CLI v2 with accesses described above.

## Setting up necessary elements

### Security groups

First, security groups for the app (GeneValidator) and for access to EFS needs to be created.
For these the files `EC2-Create-Security-Group-genevalidator.yaml`, `EC2-Create-Security-Group-EFS.yaml` are used. You need to enter a VPC ID in which you will be creating your infrastructure in place of `<your vpc ID>`.

Then each security groups gets their respective ingress (separate) and egress (common) rules set up.

### Target group

