output "instance_arn" {
  value       = aws_instance.server.arn
  description = "The arn of the created instance"
}

output "instance_public_ip" {
  value       = aws_instance.server.public_ip
  description = "The public IP of the created instance"
}
