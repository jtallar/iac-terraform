output "vpc_id" {
  value       = module.vpc.id
  description = "The ID of the created VPC"
}

output "subnet_ids" {
  value       = module.vpc.subnet_ids
  description = "The list of subnet ids"
}

output "instance_arn" {
  value       = aws_instance.server.arn
  description = "The arn of the created instance"
}

output "instance_public_ip" {
  value       = aws_instance.server.public_ip
  description = "The public IP of the created instance"
}
