provider "aws" {
  region = "ap-south-1"  
  
}

resource "aws_iam_user" "my_user" {
  name = "my-user"  

  tags = {
    Name = "My User"
  }
}

