provider "aws" {
  region  = "ap-northeast-1"
  profile = "dev"
}

# CloudFront等で us-east-1 が必要な場合は追加
provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = "dev"
}

# 【追加】Route 53 や ACM の管理用（管理アカウント側へアクセスするプロバイダ）
provider "aws" {
  alias   = "management"
  region  = "ap-northeast-1"
  profile = "dev" # または管理アカウント用のプロファイルがあればそちらを指定

  # 管理アカウント側のホストゾーンを操作するための権限委譲設定
  assume_role {
    role_arn     = "arn:aws:iam::761018859875:role/TerraformRoute53CrossAccountRole"
    session_name = "TerraformRoute53ManagementSession"
  }
}