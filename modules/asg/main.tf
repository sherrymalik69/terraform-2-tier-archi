resource "aws_autoscaling_group" "sample-asg" {
  name                 = "sample-asg"
  launch_configuration = aws_launch_configuration.sample-lg.name
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier = toset(var.private_subnet_ids)
  target_group_arns    = [var.aws_lb_target_group_arn]
  force_delete = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "sample-lg" {
  name_prefix          = " auto-"
  image_id             = var.ami
  instance_type        = "t2.micro"
  key_name             = var.aws_key_name
  security_groups      = [var.sec-group-id]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_size = 12
    volume_type = "gp2"
  }

}
