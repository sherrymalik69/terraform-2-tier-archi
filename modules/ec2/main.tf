/*resource "aws_instance" "web" {
  count         = length(var.subnet_id)       #for creating  subnets  of all public subnets_id we capture in list output -   
  ami           = "${var.ami}"                                                                                           
  instance_type = "t2.micro"
  key_name = aws_key_pair.key_through_terra.key_name                                                                          
  vpc_security_group_ids = [aws_security_group.sec-for-terra.id]
  subnet_id = var.subnet_id[count.index]
  #subnet_id = var.subnet_id
  tags = {
    Name = "webserver-${count.index+1}"
    #Name = "webserver"
  }
}*/


resource "tls_private_key" "mykey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "key_through_terra" {
  key_name   = "key_through_terra"
  public_key = tls_private_key.mykey.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.mykey.private_key_pem
  filename = "C:/Users/BJS-034/Desktop/mykey.pem"
}



resource "aws_security_group" "sec-for-terra" {
  name        = "sec-for-terra"
  description = "Allowing SSH and HTTP traffic"
  vpc_id      = var.vpcid

  dynamic "ingress" {

    for_each = [22,80]
    iterator = ingress_port
    content {
        description      = "SSH from VPC"
        from_port        = ingress_port.value
        to_port          = ingress_port.value
        protocol         = "tcp"
        #cidr_blocks      = ["0.0.0.0/0"]
        security_groups = [var.elb_security_group_id]
    }

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}
