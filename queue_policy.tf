resource "aws_sqs_queue_policy" "template_queue_policy" {
  queue_url = aws_sqs_queue.template_queue.id

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "${aws_sqs_queue.template_queue.name}-policy",
    Statement = [
      {
        Sid       = "AllowSendMessage",
        Effect    = "Allow",
        Principal = {
          AWS = "*"  # You might want to restrict this to specific AWS accounts or roles
        },
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.template_queue.arn,
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = data.terraform_remote_state.global.outputs.account_id
          }
        }
      },
      {
        Sid       = "AllowReceiveDeleteMessage",
        Effect    = "Allow",
        Principal = {
          AWS = "*"  # You might want to restrict this to specific AWS accounts or roles
        },
        Action    = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Resource  = aws_sqs_queue.template_queue.arn
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "dlq_policy" {
  queue_url = aws_sqs_queue.dlq.id

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "${aws_sqs_queue.dlq.name}-policy",
    Statement = [
      {
        Sid       = "AllowSendMessageFromMainQueue",
        Effect    = "Allow",
        Principal = {
          AWS = "*"
        },
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.dlq.arn,
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sqs_queue.template_queue.arn
          }
        }
      },
      {
        Sid       = "AllowReceiveDeleteMessage",
        Effect    = "Allow",
        Principal = {
          AWS = "*"  # You might want to restrict this to specific AWS accounts or roles
        },
        Action    = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Resource  = aws_sqs_queue.dlq.arn
      }
    ]
  })
}
