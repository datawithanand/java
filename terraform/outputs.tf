output "ec2_public_ip" {
  value       = aws_instance.app_server[0].public_ip
  description = "Public IP of the EC2 instance"
}
