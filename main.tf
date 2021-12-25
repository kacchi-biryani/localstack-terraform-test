
provider "aws" {
  region                      = "eu-central-1"
  access_key                  = "123"
  secret_key                  = "qwe"
  skip_requesting_account_id  = true
  skip_credentials_validation = true
  endpoints {
    sns = "http://localhost:4566"
    sqs = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
}

resource "aws_sns_topic" "justTrack-staging-sns" {
  name = "justTrack-staging-sns"
}

resource "aws_sqs_queue" "justTrack-staging-sqs" {
  name = "justTrack-staging-sqs"
}

resource "aws_sns_topic" "justTrack-live-sns" {
  name = "justTrack-live-sns"
}

resource "aws_sqs_queue" "justTrack-live-sqs" {
  name = "justTrack-live-sqs"
}

resource "aws_sns_topic" "justView-staging-sns" {
  name = "justView-staging-sns"
}

resource "aws_sqs_queue" "justView-staging-sqs" {
  name = "justView-staging-sqs"
}

resource "aws_sns_topic" "justView-live-sns" {
  name = "justView-live-sns"
}

resource "aws_sqs_queue" "justView-live-sqs" {
  name = "justView-live-sqs"
}

resource "aws_sns_topic_subscription" "justTrack-staging-sns-topic" {
  topic_arn                       = aws_sns_topic.justTrack-staging-sns.arn
  protocol                        = "sqs"
  endpoint                        = aws_sqs_queue.justTrack-staging-sqs.arn
}

resource "aws_sns_topic_subscription" "justTrack-live-sns-topic" {
  topic_arn                       = aws_sns_topic.justTrack-live-sns.arn
  protocol                        = "sqs"
  endpoint                        = aws_sqs_queue.justTrack-live-sqs.arn
}

resource "aws_sns_topic_subscription" "justView-staging-sns-topic" {
  topic_arn                       = aws_sns_topic.justView-staging-sns.arn
  protocol                        = "sqs"
  endpoint                        = aws_sqs_queue.justView-staging-sqs.arn
}

resource "aws_sns_topic_subscription" "justView-live-sns-topic" {
  topic_arn                       = aws_sns_topic.justView-live-sns.arn
  protocol                        = "sqs"
  endpoint                        = aws_sqs_queue.justView-live-sqs.arn
}