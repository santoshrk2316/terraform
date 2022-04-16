provider "aws" {
  region = var.aws_region
}


#Create security group with firewall rules
resource "aws_security_group" "security_k8s_port" {
  name        = "security_k8s_port"
  description = "security group for k8s"

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

 # outbound from k8s server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "security_k8s_port"
  }
}

resource "aws_instance" "k8s_master" {
  ami           = "ami-06a0b4e3b7eb7a300"
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [ "security_k8s_port"]
  tags= {
    Name = "master_instance"
  }
}
resource "aws_instance" "k8s_node01" {
  ami           = "ami-06a0b4e3b7eb7a300"
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [ "security_k8s_port"]
  tags= {
    Name = "node01_instance"
  }
}
resource "aws_instance" "k8s_node02" {
  ami           = "ami-06a0b4e3b7eb7a300"
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [ "security_k8s_port"]
  tags= {
    Name = "node02_instance"
  }
}

# Create Elastic IP address
#resource "aws_eip" "k8s_eip" {
#  vpc      = true
#  instance = aws_instance.k8s_master.id
#  tags= {
#    Name = "jenkins_elstic_ip"
#  }
#}
