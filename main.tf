# Provider

provider aws {
    region = "us-east-2"
}

# Create Bastion-key

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Create buckets

resource "aws_s3_bucket" "example" {
  bucket = "kaizen-zhanyl"
}

resource "aws_s3_bucket" "example1" {
  bucket_prefix = "kaizen-"
}

# Import buckets

resource "aws_s3_bucket" "example2" {
  bucket_prefix = "hw-bucket1"
}

resource "aws_s3_bucket" "example3" {
  bucket_prefix = "hw-bucket2"
}

# terraform import aws_s3_bucket.example2 hw-bucket1
# terraform import aws_s3_bucket.example3 hw-bucket2

# Create users

resource "aws_iam_user" "users" {
  for_each = toset (["jenny","rose","lisa","jisoo"])
  name = each.key 
}

# Create group

resource "aws_iam_group" "group" {
  name = "blackpink"
}

# Add users to group

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    for i in aws_iam_user.users : i.name
  ]

  group = aws_iam_group.group.name
}
