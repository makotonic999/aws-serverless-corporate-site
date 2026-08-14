output "s3_bucket_name" {
  value       = aws_s3_bucket.site.id
  description = "okada-chikuro-site-j4cdeh87"
}

output "custom_domain_url" {
  value       = "https://${var.domain_name}"
  description = "独自ドメインWebサイトのURL"
}