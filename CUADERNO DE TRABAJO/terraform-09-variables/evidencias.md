609  mkdir terraform-09-variables\ncd terraform-09-variables\ncode .
  610  terraform init\nterraform validate\nterraform plan
  611  $env:TF_VAR_entorno="TEST"\nterraform plan