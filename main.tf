module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "netflix-server"

  instance_type          = var.instance_type
  ami                    = var.ami
  key_name               = var.key_pair
  monitoring             = true
  vpc_security_group_ids = [module.sg.security_group_id]
  subnet_id              = var.subnet_id
  user_data              = file("userdata.sh")

  root_block_device = [{
    volume_size           = 25
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
  }]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "netflix-server"
  }
}
