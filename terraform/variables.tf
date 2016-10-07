variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
    description = "The AWS region to create things in."
    default = "eu-west-1"
}

# My own AMI
variable "aws_amis" {
    default = {
        eu-west-1 = "ami-21ffbf52"
    }
}

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.
Example: ~/.ssh/terraform.pub
DESCRIPTION
}
variable "private_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.
Example: ~/.ssh/terraform
DESCRIPTION
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}
