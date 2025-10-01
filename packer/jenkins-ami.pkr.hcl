source "amazon-ebs" "jenkins" {
  region           = "us-east-1"
  instance_type    = "t3.micro"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }
    most_recent = true
    owners      = ["099720109477"]  # ✅ Canonical's official owner ID
  }

  ssh_username         = "ubuntu"
  ami_name             = "jenkins-ami-{{timestamp}}"
  iam_instance_profile = "packer-admin-profile"  # ✅ IAM profile created via Terraform
}

build {
  sources = ["source.amazon-ebs.jenkins"]

  provisioner "shell" {
    script = "provision.sh"
  }
}
