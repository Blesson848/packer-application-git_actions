packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon-ec2" {
  ami_name      = local.image_name
  instance_type = var.instance_type
  ssh_username  = "ec2-user"
  source_ami    = var.ami

  tags = {
    Name    = local.image_name
    Project = var.project_name
    Env     = var.project_env
  }


}


build {
  sources = ["source.amazon-ebs.amazon-ec2"]

  provisioner "shell" {
    script          = "./setup.sh"
    execute_command = "sudo {{.Path}} ${var.application_repository}"
  }
}
