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

output "product_events_queue_url" {
  description = "URL of the product events queue"
  value       = aws_sqs_queue.product_events_queue.url
}

output "product_events_queue_arn" {
  description = "ARN of the product events queue"
  value       = aws_sqs_queue.product_events_queue.arn
}

output "product_events_dlq_url" {
  description = "URL of the product events dead letter queue"
  value       = aws_sqs_queue.product_events_dlq.url
}

output "product_events_dlq_arn" {
  description = "ARN of the product events dead letter queue"
  value       = aws_sqs_queue.product_events_dlq.arn
}