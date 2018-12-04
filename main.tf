resource "aws_key_pair" "tf_demo" {
  key_name   = "terraform_created_key_pair"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "my-instance" {

  ami           = "${var.amazon_image}"
  instance_type = "${var.instance_type}"
  #"${resource_type.logical_name.attribute}"
  key_name  = "${aws_key_pair.tf_demo.key_name}"
  user_data = "${file("scripts/apache.sh")}"

  tags {
    Name = "My_terraform_server"
    type = "test"
  }
}

output "ip"
{
  value = "${aws_instance.my-instance.public_ip}"
}
