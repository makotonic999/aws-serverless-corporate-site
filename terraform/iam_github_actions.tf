# 1. GitHub の OIDC プロバイダーを AWS に登録
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] # GitHub OIDC の標準サムプリント
}

# 2. GitHub Actions が引き受ける IAM ロール
resource "aws_iam_role" "github_actions_deploy" {
  name = "GitHubActionsFrontendDeployRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:makotonic999/aws-serverless-corporate-site:*"
          }
        }
      }
    ]
  })
}

# 3. S3同期およびCloudFrontインバリデーション用のインラインポリシー
resource "aws_iam_role_policy" "deploy_policy" {
  name = "FrontendDeployPolicy"
  role = aws_iam_role.github_actions_deploy.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::okada-chikuro-site-hmd17889",
          "arn:aws:s3:::okada-chikuro-site-hmd17889/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "cloudfront:CreateInvalidation"
        ]
        Resource = "*"
      }
    ]
  })
}

# 4. ワークフローで指定するためにロールの ARN を出力しておく
output "github_actions_role_arn" {
  value       = aws_iam_role.github_actions_deploy.arn
  description = "IAM Role ARN for GitHub Actions OIDC"
}