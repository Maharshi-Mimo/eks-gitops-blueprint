terraform { 
    required_version = ">= 1.6"
    required_providers { 
        aws = {
            source = "hashicorp/aws" 
            version = "~> 5.0"
        }
        kubernetes = {
            source = "hashicorpt/kubernetes"
            version = "~> 2.0"
        }
        helm = {
            source = "hashicorp/helm"
            version = "~> 2.0"
        }
    }
    backend "s3" {
    bucket = "tf_state_bucket"
    key = "gitops/tfstate"
    region = "us-east-1"
    dynamodb_table = "tf_state_lock_table"
    encrypt = true
    }

}

