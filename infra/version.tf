terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
  backend "s3" {
    bucket         = "tf-state-bucket-123456789012"
    key            = "gitops/tfstate"
    region         = "us-east-2"
    dynamodb_table = "tf_state_lock_table"
    encrypt        = true
  }

}

