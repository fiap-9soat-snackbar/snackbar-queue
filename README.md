# Snackbar SQS Queue Infrastructure

This Terraform configuration provisions an AWS SQS queue infrastructure for the Snackbar application, including a main queue, dead letter queue (DLQ), and associated policies.

## 🚀 Features

- **Main SQS Queue**: Primary message queue for the Snackbar application
- **Dead Letter Queue (DLQ)**: Captures failed messages after multiple processing attempts
- **Queue Policies**: Secure access control for both queues
- **Redrive Policy**: Configures message handling after processing failures
- **Redrive Allow Policy**: Controls which source queues can use the DLQ
- **CloudWatch Integration**: Monitoring and metrics for queue operations
- **Terraform Provisioning**: Infrastructure-as-Code (IaC) for repeatable deployments

## 📐 Architecture

The SQS infrastructure follows this flow for message processing:

1. **Producer** → **Main Queue**
   - Messages are sent to the main queue for processing
2. **Consumer** ← **Main Queue**
   - Consumers retrieve and process messages from the main queue
3. **Main Queue** → **DLQ** (for failed messages)
   - After exceeding the maximum receive count, failed messages are sent to the DLQ
4. **DLQ Monitoring**
   - Failed messages in the DLQ can be monitored and reprocessed as needed

## 🛠️ Project Structure

```
.
├── main.tf                 # Main Terraform configuration with all resources
├── variables.tf            # Input variable definitions
├── outputs.tf              # Output value definitions
├── locals.tf               # Local variable definitions
├── providers.tf            # Provider configuration
├── terraform.tfvars        # Variable values for deployment
└── policies/               # JSON policy templates
    ├── main_queue_policy_template.json  # Main queue policy template
    ├── dlq_policy_template.json         # DLQ policy template
    ├── redrive_policy.json              # Redrive policy configuration
    └── dlq_allow_policy.json            # DLQ allow policy configuration
```

## 🛠️ Terraform Resources

| Resource Type | Purpose |
|---------------|---------|
| `aws_sqs_queue` | Creates the main SQS queue and DLQ |
| `aws_sqs_queue_policy` | Configures access policies for both queues |
| `aws_sqs_queue_redrive_policy` | Defines how failed messages are handled |
| `aws_sqs_queue_redrive_allow_policy` | Controls which queues can use the DLQ |

## 🚀 Deployment

### Prerequisites
1. **AWS CLI Configured** with valid credentials
2. **Terraform v1.0+** installed

### Configuration Variables
- `max_receive_count`: Maximum number of processing attempts before sending to DLQ (default: 5)
- `message_retention_seconds`: How long messages are kept (default: 345600 seconds / 4 days)
- `visibility_timeout_seconds`: How long messages are invisible after being received (default: 30 seconds)

## 🛠️ How to Run Terraform

### Plan Infrastructure
Preview changes before applying them (dry-run):
```
terraform plan
```

### Apply Configuration
Create or update AWS resources:
```
terraform apply
```

### Destroy Resources
Remove all created resources:
```
terraform destroy
```
