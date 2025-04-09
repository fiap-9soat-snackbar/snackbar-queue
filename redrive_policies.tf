# Redrive policy for the main queue
# This sends messages to the DLQ after the specified number of failures
resource "aws_sqs_queue_redrive_policy" "template_queue_redrive_policy" {
  queue_url = aws_sqs_queue.template_queue.id
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })
}

# Redrive allow policy for the DLQ
# This controls which source queues can use this queue as DLQ
resource "aws_sqs_queue_redrive_allow_policy" "dlq_redrive_allow_policy" {
  queue_url = aws_sqs_queue.dlq.id
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.template_queue.arn]
  })
}
