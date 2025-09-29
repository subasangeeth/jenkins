resource "aws_instance" "ec2" {
  ami           = "ami-01b6d88af12965bb6"
  instance_type = "t3.micro"

  tags = {
    Name = "CICD"
  }
  
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  key_name=aws_key_pair.sshkey.key_name
}
resource "aws_key_pair" "sshkey" {
  key_name   = "sshkey"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
 
}

resource "local_file" "sshkey" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "ansible/sshkey.pem"
    file_permission = "0600"
}

resource "aws_security_group" "TF_SG" {
  name        = "security group using Terraform"
  description = "security group using Terraform"
  vpc_id      = "vpc-03e3dc779bb4ef4f2"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }



  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "TF_SG"
  }
}
