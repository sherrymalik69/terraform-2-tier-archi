

output "elb_security_group_id" {

    value = aws_security_group.elb-sec.id
  
}

output "aws_lb_target_group" {

    value = aws_lb_target_group.sample-tg.arn
  
}