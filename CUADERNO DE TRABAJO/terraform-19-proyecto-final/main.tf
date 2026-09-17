

provider "aws" {
  region = var.region

  s3_use_path_style           = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "https://s3.us-east-1.amazonaws.com"
  }
}

data "aws_vpc" "vpc_principal" {
  default = true
}

resource "aws_subnet" "publica" {
  vpc_id                  = data.aws_vpc.vpc_principal.id
  cidr_block              = var.subnet_publica_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.nombre_proyecto}-publica"
  }
}

resource "aws_subnet" "privada" {
  vpc_id     = data.aws_vpc.vpc_principal.id
  cidr_block = var.subnet_privada_cidr

  tags = {
    Name = "${var.nombre_proyecto}-privada"
  }
}

data "aws_internet_gateway" "gw_existente" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.vpc_principal.id]
  }
}

resource "aws_route_table" "publica_rt" {
  vpc_id = data.aws_vpc.vpc_principal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.gw_existente.id
  }

  tags = {
    Name = "${var.nombre_proyecto}-publica-rt"
  }
}

resource "aws_route_table_association" "publica_assoc" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.publica_rt.id
}

resource "aws_instance" "servidor_aula" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.publica.id

  tags = {
    Name = "${var.nombre_proyecto}-ec2"
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "bucket_aula" {
  bucket        = "ivan-terraform-ejercicio-03-${random_string.suffix.result}"
  force_destroy = true

  tags = {
    Name = "${var.nombre_proyecto}-bucket"
  }
}