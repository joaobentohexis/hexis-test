terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Optional: S3 backend config (uncomment and fill if needed)
  # backend "s3" {
  #   bucket = "my-terraform-state"
  #   key    = "envs/staging/terraform.tfstate"
  #   region = "eu-west-1"
  # }
}

provider "aws" {
  region = "eu-west-1"
}