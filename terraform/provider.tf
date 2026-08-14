# provider.tf

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# メインプロバイダ（東京リージョン）
provider "aws" {
  region = "ap-northeast-1"
}

# CloudFront用 ACM 証明書プロバイダ（バージニア北部リージョン必須）
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}