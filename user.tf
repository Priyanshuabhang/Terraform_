provider "aws" {
  region = "ap-south-1"  
  
}

resource "aws_iam_user" "my_user" {
  name = "my-user-name"  # Set your desired username

  tags = {
    Name = "My User"
  }
}

resource "aws_iam_user_policy_attachment" "my_user_attachment" {
  user       = aws_iam_user.my_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"  # Example policy, replace with desired ARN
}
