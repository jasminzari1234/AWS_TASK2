resource "aws_instance" "web" {
  ami           = "ami-0447a12f28fddb066"
  instance_type = "t2.micro"
  key_name = "key1"
  security_groups =["${aws_security_group.ssh1_http.name}"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/ABC/Downloads/key1.pem")
    host     = aws_instance.web.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd  php git -y",
      "sudo systemctl restart httpd",
      "sudo systemctl enable httpd",
    ]
  }

  tags = {
    Name = "tfinstance"
  }

}