resource "aws_iam_user" "cloudwatch_exporter" {
  name = "cloudwatch_exporter"
  path = "/system/"
}

resource "aws_iam_access_key" "cloudwatch_exporter" {
  user = aws_iam_user.cloudwatch_exporter.name
}

resource "aws_iam_user_policy" "cloudwatch_policy" {
  name = "cloudwatch_policy"
  user = aws_iam_user.cloudwatch_exporter.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "cloudwatch_exporter" {
  user       = aws_iam_user.cloudwatch_exporter.name
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}
