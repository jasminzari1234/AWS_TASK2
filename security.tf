resource "aws_security_group" "ssh1_http"{
name = "ssh1_http"
description="allow ssh and http traffic"


ingress{
from_port =22
to_port =22
protocol ="tcp"
cidr_blocks=["0.0.0.0/0"]
}
ingress{
from_port =80 
to_port =80
protocol ="tcp"
cidr_blocks =["0.0.0.0/0"]
}
ingress {
    protocol   = "tcp"
    from_port  = 2049
    to_port    = 2049
    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  
  }

}

