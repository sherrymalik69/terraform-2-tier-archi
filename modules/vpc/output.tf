

output "vpcid" {

    value = aws_vpc.myvpc.id
  
}

output "public_subnet_ids" {
  #value = "${aws_subnet.public["1"].id}"   #for outputting only 1st subnet_id
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "subnet_name" {
  value = "${aws_subnet.public["1"].tags.Name}"
  
}

output "private_subnet_name" {
  value = "${aws_subnet.private["1"].tags.Name}"
  
}
output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]   #for creating list of subnet_ids of all private subnets
}

/*output "subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]     for creating list of subnet_ids of all public subnets
}*/

output "az" {

    value = "${aws_subnet.private["1"].availability_zone}"
  
}

/*data "aws_availability_zones" "azs" {
  filter {
    name   = "region-name"
    values = ["us-east-1"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

output "azss" {

  value = data.aws_availability_zones.azs.names
  
}*/