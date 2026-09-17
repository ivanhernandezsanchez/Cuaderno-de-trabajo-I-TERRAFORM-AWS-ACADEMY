mkdir terraform-10-tfvars\ncd terraform-10-tfvars\ncode .
  615  terraform init\nterraform plan -var-file="dev.tfvars"
  616  terraform plan -var-file="test.tfvars".
  617  terraform plan -var-file="test.tfvars"