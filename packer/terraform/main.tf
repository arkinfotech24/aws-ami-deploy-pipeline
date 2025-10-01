provider "aws" {
  region = "us-east-1"
}

# IAM User for Packer CLI (optional)
resource "aws_iam_user" "packer_admin" {
  name = "packer-admin"
}

resource "aws_iam_user_policy_attachment" "admin_attach" {
  user       = aws_iam_user.packer_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# IAM Role for EC2 Instance
resource "aws_iam_role" "packer_role" {
  name = "packer-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "packer_admin_policy" {
  role       = aws_iam_role.packer_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "packer_profile" {
  name = "packer-admin-profile"
  role = aws_iam_role.packer_role.name
}

# EC2 Instance for Jenkins
resource "aws_instance" "jenkins_server" {
  ami                         = "ami-0007c21b6e43803fc"              # ✅ AMI ID
  instance_type               = "t3.micro"
  key_name                    = "terraform"                          # ✅ Key pair
  subnet_id                   = "subnet-04977df9764f68009"           # ✅ Subnet
  vpc_security_group_ids      = ["sg-0edaa040cab1999cd"]             # ✅ Security group
  iam_instance_profile        = aws_iam_instance_profile.packer_profile.name

  tags = {
    Name        = "Terraform-Jenkins-Server(IaC)"
    Environment = "dev"
  }
}
