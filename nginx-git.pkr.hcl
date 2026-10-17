packer {
  required_version = ">= 1.9.0"
  required_plugins {
    amazon = {
      version = ">= 1.2.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "nginx-git" {
  region                  = "eu-west-2"
  instance_type           = "t3.micro"
  ssh_username            = "ec2-user"
  source_ami              = "ami-06cdac14c9c4da91b" # Replace with a valid Amazon Linux AMI ID
  ami_name                = "nginx-git-packer"
  ami_virtualization_type = "hvm"
}

build {
  name    = "nginx-git-build"
  sources = ["source.amazon-ebs.nginx-git"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo '<h1>Hello from Techblitz build by Packer</h1>' | sudo tee /usr/share/nginx/html/index.html",
      "sudo yum install -y git"
    ]
  }

  post-processor "shell-local" {
    inline = ["echo 'My build is finished'"]
  }
}