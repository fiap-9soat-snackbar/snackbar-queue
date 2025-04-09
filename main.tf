data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_key
    region = var.remote_state_region
  }
}

# Dead Letter Queue
resource "aws_sqs_queue" "dlq" {
  name = "${data.terraform_remote_state.global.outputs.project_name}-dlq"
  fifo_queue = false
  message_retention_seconds = var.message_retention_seconds
  
  tags = {
    Name        = "${data.terraform_remote_state.global.outputs.project_name}-dlq"
    Environment = data.terraform_remote_state.global.outputs.environment
    Project     = data.terraform_remote_state.global.outputs.project_name
  }
}

# Main Queue
resource "aws_sqs_queue" "template_queue" {
  name                       = "${data.terraform_remote_state.global.outputs.project_name}-queue"
  fifo_queue                 = false
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  
  tags = {
    Name        = "${data.terraform_remote_state.global.outputs.project_name}-queue"
    Environment = data.terraform_remote_state.global.outputs.environment
    Project     = data.terraform_remote_state.global.outputs.project_name
  }
}