# Set write access for external managed-aws-rds service
partition "tgw" {
service "managed-aws-rds" {
  policy = "write"
  intentions = "read"
}
}