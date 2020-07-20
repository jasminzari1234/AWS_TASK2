//creating new volume

resource "aws_efs_file_system" "task2" {
  depends_on = [
    aws_instance.web
  ]
  creation_token = "volume"

  tags = {
    Name = "MyEFS"
  }
}

resource "aws_efs_mount_target" "alpha" {
  depends_on =  [
                aws_efs_file_system.task2
  ] 
  file_system_id = "${aws_efs_file_system.task2.id}"
  subnet_id      = aws_instance.web.subnet_id
  security_groups = [ aws_security_group.ssh1_http.id ]
}