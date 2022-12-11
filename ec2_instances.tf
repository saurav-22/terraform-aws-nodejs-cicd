# Key pair
resource "aws_key_pair" "tf_key" {
 key_name = "project-key"
  public_key = file("/home/ec2-user/.ssh/id_rsa.pub")
}

#Create Bastion host
resource "aws_instance" "bastion" {
    tags = { 
    Name = "Bastion"
  }
  ami = "ami-074dc0a6f6c764218"
  instance_type = "t2.micro"
  key_name = aws_key_pair.tf_key.key_name
  subnet_id      = aws_subnet.public-subnet-1a.id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  associate_public_ip_address = true
  availability_zone = "ap-south-1a"
}

#Create Jenkins host
resource "aws_instance" "jenkins" {
    tags = {
    Name = "Jenkins"
  }
  ami = "ami-074dc0a6f6c764218"
  instance_type = "t2.micro"
  key_name = aws_key_pair.tf_key.key_name
  subnet_id      = aws_subnet.private-subnet-1a.id
  vpc_security_group_ids = [aws_security_group.private.id]
  availability_zone = "ap-south-1a"
}

#Create App host
resource "aws_instance" "app" {
    tags = {
    Name = "App"
  }
  ami = "ami-074dc0a6f6c764218"
  instance_type = "t2.micro"
  key_name = aws_key_pair.tf_key.key_name
  subnet_id      = aws_subnet.private-subnet-1a.id
  vpc_security_group_ids = [aws_security_group.private.id]
  availability_zone = "ap-south-1a"
}
