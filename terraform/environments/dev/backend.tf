terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # ステートの保存先をS3に設定（※バックエンド作成後にコメントアウトを外します）
  # backend "s3" {
  #   bucket         = "okadachikuro-dev-tfstate"
  #   key            = "dev/terraform.tfstate"
  #   region         = "ap-northeast-1"
  #   dynamodb_table = "terraform-locks-dev"
  #   profile        = "dev"
  # }
}