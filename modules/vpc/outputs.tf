output "id" {
  value       = aws_vpc.this.id
  description = "The ID of the created VPC"
}

output "subnet_ids" {
  value       = aws_subnet.this[*].id
  description = "The IDs of the created subnets"
}

output "network_acl_id" {
  value       = aws_network_acl.public.id
  description = "The ID of the Public Network ACL created in the VPC"
}
