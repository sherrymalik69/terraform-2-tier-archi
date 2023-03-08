########################################################

vpc_cidr = "192.168.0.0/24"



public_subnets = {
    "1" = {
      cidr_block        = "192.168.0.0/27"
      availability_zone = "us-east-1a"
    },
    "2" = {
      cidr_block        = "192.168.0.32/27"
      availability_zone = "us-east-1b"
    }

}  

private_subnets = {
    "1" = {
      cidr_block        = "192.168.0.64/27"
      availability_zone = "us-east-1a"
    },
    "2" = {
      cidr_block        = "192.168.0.96/27"
      availability_zone = "us-east-1b"
    }
    "3" = {
      cidr_block        = "192.168.0.128/27"
      availability_zone = "us-east-1a"
    },
    "4" = {
      cidr_block        = "192.168.0.160/27"
      availability_zone = "us-east-1b"
    }

}


route-for-public-rt = {
    
    "igw" = "0.0.0.0/0"
}

ami = "ami-006dcf34c09e50022"
