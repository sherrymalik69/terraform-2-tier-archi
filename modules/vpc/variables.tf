

variable "vpc_cidr" {

    type = string
  
}

variable "route-for-public-rt" {

    type = map(string)
  
}

variable "private_subnets" {
  
  type = map

}

variable "public_subnets" {
  
  type = map

}



