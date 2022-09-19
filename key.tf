/*
resource "aws_key_pair" "elastic_ssh_key" {
  key_name="tf-kp"
  public_key= file("~/.ssh/id_rsa.pub")
  
  provisioner "local-exec" { 
  command = "echo '${aws_key_pair.elastic_ssh_key.key_name}' > /home/paragon/Downloads/elasticstack-terraform-aws-main(1)/elasticstack-terraform-aws-main/myKey.pem"
  }
}

*/
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "tf-kp"       # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./tf-kp.pem"
  }
}
