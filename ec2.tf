data "aws_ami" "fetch_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "ec2-name" {
  type    = list(any)
  default = ["first-ec2-web", "second-ec2-web", "third-ec2-web"]
}

resource "aws_instance" "build_web_server" {
  # Fetch AMI ID from the Terraform data function
  ami           = data.aws_ami.fetch_ami.id
  instance_type = "t2.micro"

  tags = {
    Name = element(var.ec2-name, count.index)
  }
  
  # Counter which defines the number of servers to be created in a loop.
  count = 1
}
