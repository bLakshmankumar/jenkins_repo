provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.region  
}

resource "aws_instance" "jenkismaster" {
    ami = var.ami
    instance_type = var.instance_type
    count = "1"
    key_name = var.key_name

provisioner "remote-exec" {
    inline = [
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt update -qq",
      "sudo apt install -y default-jre",
      "sudo apt install -y jenkins",
      "sudo systemctl start jenkins",
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("****.pem")
  }

  tags = {
    "Name"      = "Jenkins_Server"
    "Terraform" = "true"
  }
}

/* user_data = <<EOC
#!/bin/bash
 sudo apt update
 sudo apt install default-jre -y
 sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
 sudo sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
 sudo apt update
 sudo apt install jenkins -y
echo "#########   all commands executed successfuly !! ########## "
EOC

tags = {
    "Name"      = "Jenkins_Server"
    "Terraform" = "true"
  }
} */

resource "aws_security_group" "demo_sg" {
  name = "sec_grp"
  description = "Allow Jenkins and SSH traffic via Terraform"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}