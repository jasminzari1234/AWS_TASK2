

resource "null_resource" "null2"  {
	provisioner "local-exec" {
	    command = "echo  ${aws_instance.web.public_ip} > public_ip.txt"
  	}
}
resource "null_resource" "null3"  {

depends_on = [
    aws_efs_mount_target.alpha
  ]


  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/ABC/Downloads/key1.pem")
    host     = aws_instance.web.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo mount -t '${aws_efs_file_system.task2.id}':/ /var/www/html",
      "sudo rm -rf /var/www/html/*",
      "sudo git clone https://github.com/jasminzari1234/task2_html.git /var/www/html/" 
    ]
  }
}


resource "null_resource" "null1"  {

depends_on = [
         null_resource.null3    
  ]

	provisioner "local-exec" {
	    command = "chrome  ${aws_instance.web.public_ip}"
  	}
}