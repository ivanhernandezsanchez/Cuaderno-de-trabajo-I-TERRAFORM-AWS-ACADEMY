
output "vpc_id" {
  description = "El identificador de la VPC"
  value       = data.aws_vpc.vpc_principal.id
}

output "ec2_id" {
  description = "El identificador de la instancia EC2"
  value       = aws_instance.servidor_aula.id # Ajusta 'servidor_aula' al nombre de tu recurso EC2
}


output "ec2_public_ip" {
  description = "La dirección IP pública de la instancia EC2"
  value       = aws_instance.servidor_aula.public_ip
}


output "bucket_name" {
  description = "El nombre del bucket S3 creado"
  value       = aws_s3_bucket.bucket_aula.id
}