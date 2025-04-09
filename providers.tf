terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
  
  backend "s3" {
    # These values should be provided during terraform init or via environment variables
  }
}

provider "aws" {
  region = data.terraform_remote_state.global.outputs.region
  
  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Environment = data.terraform_remote_state.global.outputs.environment
      Project     = data.terraform_remote_state.global.outputs.project_name
    }
  }
}
