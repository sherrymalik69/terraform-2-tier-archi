resource "aws_db_instance" "dev-db" {
  allocated_storage    = 10
  db_name              = "devdb"
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  username             = "${var.username}"
  password             = "${var.password}"
  parameter_group_name = aws_db_parameter_group.db-parameter-group.name
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name
  vpc_security_group_ids = [aws_security_group.db.id]
  availability_zone = var.availability_zone
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "rds-subnet-group" {
  name        = "rds-subnet-group"
  description = "Subnet group for RDS instances"
  subnet_ids  = [var.private_subnet_ids["2"],var.private_subnet_ids["3"]]
}

resource "aws_db_parameter_group" "db-parameter-group" {
  name        = "mysql8-parameters"
  family      = "mysql8.0"
  
  parameter {
    name         = "character_set_server"
    value        = "utf8mb4"
    apply_method = "immediate"
  }
  
  parameter {
    name         = "collation_server"
    value        = "utf8mb4_unicode_ci"
    apply_method = "immediate"
  }
}

resource "aws_security_group" "db" {
  name_prefix = "rds-"
  vpc_id      = var.vpcid

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.sec-group-id]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}