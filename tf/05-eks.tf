resource "aws_iam_role" "cbr-exchange" {
  name = var.company_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cbr-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cbr-exchange.name
}

resource "aws_iam_role_policy_attachment" "eks-vpc-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cbr-exchange.name
}

resource "aws_eks_cluster" "cbr-exchange" {
  name     = var.company_name
  role_arn = aws_iam_role.cbr-exchange.arn
  # version  = "1.21"

  vpc_config {
    subnet_ids = [
      aws_subnet.public-subnet-A.id,
      aws_subnet.public-subnet-B.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cbr-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cbr-AmazonEKSClusterPolicy,
  ]
  tags = {
    "email" = var.owner_email
    "Name"  = "cbr-eks"
  }
}
