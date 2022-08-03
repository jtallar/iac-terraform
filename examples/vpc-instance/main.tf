module "vpc" {
  source = "../../modules/vpc"

  name           = "sample-vpc"
  cidr_block     = "172.168.0.0/20"
  subnet_newbits = 4
  subnet_count   = 1
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = module.vpc.subnet_ids[0]

  user_data = templatefile("${path.module}/user-data.sh", {
    server_port = var.server_port
    server_text = "This is ${var.server_name}"
  })

  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = var.server_name
  }
}

resource "aws_security_group" "instance" {
  name   = "${var.server_name}-instance-sg"
  vpc_id = module.vpc.id

  tags = {
    Name = "${var.server_name}-instance-sg"
  }
}

resource "aws_security_group_rule" "allow_server_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.instance.id

  from_port   = var.server_port
  to_port     = var.server_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.instance.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}

locals {
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}
