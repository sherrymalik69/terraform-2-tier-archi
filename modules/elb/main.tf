resource "aws_lb_target_group" "sample-tg" {
  name        = "sample-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpcid

  health_check {
    interval            = 30
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

/*resource "aws_lb_target_group_attachment" "attachment" {
  count = "${length(var.ec2-id)}"
  target_group_arn = aws_lb_target_group.sample-tg.arn
  target_id        = "${element(var.ec2-id,count.index)}"
  port             = 80
}*/  #we use this resource for attaching already created ec2 instances to elb

resource "aws_lb_listener" "listener" {
  count = "${length(var.public_subnet_ids)}"
  load_balancer_arn = "${aws_lb.myelb[count.index].arn}"
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sample-tg.arn
  }
}

resource "aws_lb" "myelb" {
  count = "${length(var.public_subnet_ids)}"  
  name               = "myelb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb-sec.id]
  subnets            = toset(var.public_subnet_ids)

  tags = {
    Environment = "testing"
  }
}

resource "aws_security_group" "elb-sec" {
  name_prefix = "elb-"
  vpc_id      = var.vpcid

  dynamic "ingress" {
    for_each = [22,80]
    iterator = ingress_port
    content {
      description      = "SSH from VPC"
      from_port        = ingress_port.value
      to_port          = ingress_port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb-security-group"
  }
}
