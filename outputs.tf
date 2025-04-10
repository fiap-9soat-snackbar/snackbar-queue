output "queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = aws_sqs_queue.template_queue.id
}

output "queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.template_queue.arn
}

output "queue_name" {
  description = "The name of the SQS queue"
  value       = aws_sqs_queue.template_queue.name
}

output "dlq_id" {
  description = "The URL for the created Amazon SQS dead letter queue"
  value       = aws_sqs_queue.dlq.id
}

output "dlq_arn" {
  description = "The ARN of the SQS dead letter queue"
  value       = aws_sqs_queue.dlq.arn
}

output "dlq_name" {
  description = "The name of the SQS dead letter queue"
  value       = aws_sqs_queue.dlq.name
}

output "region" {
  description = "The AWS region where resources are deployed"
  value       = local.region
}

output "environment" {
  description = "The environment (dev, staging, prod)"
  value       = local.environment
}

output "project_name" {
  description = "The name of the project"
  value       = local.project_name
}
