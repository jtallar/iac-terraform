output "vpc_id" {
  value       = module.vpc.id
  description = "The ID of the created VPC"
}

output "subnet_ids" {
  value       = module.vpc.subnet_ids
  description = "The list of subnet ids"
}
