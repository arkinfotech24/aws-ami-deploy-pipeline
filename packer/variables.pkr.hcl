variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"  # x86_64-compatible
}

variable "source_ami" {
  type    = string
  default = "ami-0007c21b6e43803fc"  # Ubuntu 20.04 x86_64
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "ami_name" {
  type    = string
  default = "jenkins-ami-{{timestamp}}"
}
