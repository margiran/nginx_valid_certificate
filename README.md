# Provision a Nginx and get valid certificate from Let`s encrypt on AWS Using Terraform

![datacenter image](https://github.com/margiran/nginx_valid_certificate/blob/master/diagram/nginx_valid_certificate.png?raw=true)

## Pre-requisites

* You must have [Terraform](https://www.terraform.io/downloads) installed on your computer. 
* You must have an [Amazon Web Services (AWS) account](http://aws.amazon.com/).

* You must have A domain

You will need a domain which you can control. You can use an existing one, or buy a new one which is not been taken yet. 

* AWS Route53 configured as your DNS provider

Within AWS, using Route53 you will need to configure a public hosted zone for this domain. Once created, you can then take the nameservers generated by AWS for you, and update them in your DNS registrar as your new nameservers. This will allow Terraform to use Route53 to manage the domain.


## Quick start

### Set the AWS environment variables:

Configure your [AWS access 
keys](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) as 
environment variables:
```
export AWS_ACCESS_KEY_ID=(your access key id)
export AWS_SECRET_ACCESS_KEY=(your secret access key)
```

### Clone the repository:

```
git clone git@github.com:margiran/nginx_valid_certificate.git
cd nginx_valid_certificate
```

### Clone the repository


### Build infrastructure using Terraform:

```
terraform init
terraform apply
```
### Access the cluster

Use following commands to capture the private key in a pem file:

```
terraform output private_key_pem | grep -v EOT > ~/.ssh/terraform.pem
chmod 0600 ~/.ssh/terraform.pem
```

for simplicity we generate the ssh command in an output, so try following command and use the value of output to ssh to the Nomad server:

```
terraform output ssh_server_public_ip
```

### Clean up when you're done:

```
terraform destroy
```