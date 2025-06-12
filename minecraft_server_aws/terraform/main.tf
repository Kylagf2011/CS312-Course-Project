provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "minecraft_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "minecraft_subnet" {
  vpc_id            = aws_vpc.minecraft_vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.minecraft_vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.minecraft_vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.minecraft_subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "minecraft_sg" {
  vpc_id = aws_vpc.minecraft_vpc.id

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Required for Ansible to run via SSM or key
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "minecraft_key" {
  key_name   = "minecraft-key"
  public_key = file("${pathexpand("~/.ssh/id_rsa.pub")}")
}

resource "aws_instance" "minecraft" {
  ami           = "ami-02457590d33d576c3" # Amazon Linux
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.minecraft_subnet.id
  key_name      = aws_key_pair.minecraft_key.key_name
  security_groups = [aws_security_group.minecraft_sg.id]

  tags = {
    Name = "MinecraftServer"
  }

  provisioner "local-exec" {
    command = "echo '[minecraft]' > ../ansible/inventory.ini && echo '${self.public_ip}' >> ../ansible/inventory.ini"
  }
}

output "public_ip" {
  value = aws_instance.minecraft.public_ip
}

