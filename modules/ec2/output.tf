
output "sec-group-id" {

    value = aws_security_group.sec-for-terra.id
  
}

/*output "ec2-id" {

    value = [for ec2 in aws_instance.web : ec2.id]
  
}*/

output "aws_key_name" {
    value = aws_key_pair.key_through_terra.key_name
}