variable "access_key" {

  type = string

}

variable "secret_key" {

  type = string

}


variable "vpc_cidr" {

  type = string

}

variable "private_subnets" {

  type = map(any)

}

variable "public_subnets" {

  type = map(any)

}


variable "route-for-public-rt" {

  type = map(string)

}

variable "ami" {

  type = string

}

variable "username" {

  type = string

}

variable "password" {

  type = string

}

variable "gitlab_token" {
  type = any

}

/*variable "vpcid" {

  type = any
  
}*/

/*variable "subnet_id" {

    type = any
  
}*/
