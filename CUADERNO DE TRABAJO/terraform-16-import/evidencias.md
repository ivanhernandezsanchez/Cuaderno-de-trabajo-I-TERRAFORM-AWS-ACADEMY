mkdir terraform-16-import
  648  cd terraform-16-import
  649  terraform init\nterraform import aws_vpc.vpc_importada vpc-0015b5ded9a3c8b9d
  650  terraform state list
  651  terraform plan