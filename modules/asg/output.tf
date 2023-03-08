

output "ec2-id" {
  value = "${aws_autoscaling_group.sample-asg[*].id}"
}