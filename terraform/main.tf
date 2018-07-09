provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "todo-instance" {
  ami = "ami-2a002a55"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  key_name = "EC2_Key"
  iam_instance_profile = "DynamoDBFullAccess"
  
  tags {
    Name = "terraform-example"
  }

  provisioner "remote-exec" {

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("~/workspace/SSH/EC2_Key.pem")}"
    }

    inline = [
      "nohup python /home/opt/todo/src/app.py &",
      "ps"
    ]
  }
}

resource "aws_security_group" "instance" {
  name = "terraoform-example-sg"

  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}