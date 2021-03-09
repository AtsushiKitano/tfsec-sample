remote_state {
  backend = "gcs"

  config = {
    bucket = "${get_env("PROJECT")}-state"
    prefix = "tfsec"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider google {
  project = "${get_env("PROJECT")}"
}
EOF
}

generate "backend" {
  path = "terraform.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "gcs" {}
}
EOF
}
