resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-ig"
  }
}

resource "aws_subnet" "this" {
  count = var.subnet_count

  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(var.cidr_block, var.subnet_newbits, count.index)

  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"

  tags = {
    Name = "${var.name}-${count.index}"
  }
}

resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = aws_subnet.this[*].id

  tags = {
    Name = "${var.name}-nacl-public"
  }
}

resource "aws_network_acl_rule" "allow_all_inbound" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 200
  egress         = false
  protocol       = local.any_protocol
  rule_action    = "allow"
  cidr_block     = local.all_ips

  from_port = local.any_port
  to_port   = local.any_port
}

resource "aws_network_acl_rule" "allow_all_outbound" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 200
  egress         = true
  protocol       = local.any_protocol
  rule_action    = "allow"
  cidr_block     = local.all_ips

  from_port = local.any_port
  to_port   = local.any_port
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-rt-public"
  }
}

# The default route is created implicitly and cannot be specified.
# VPC's CIDR block --> "local"

resource "aws_route" "public_ig" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = local.all_ips
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_main_route_table_association" "public_main" {
  vpc_id         = aws_vpc.this.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnets" {
  count = var.subnet_count

  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.public.id
}

locals {
  any_port     = 0
  any_protocol = "-1"
  all_ips      = "0.0.0.0/0"
}
