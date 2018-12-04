resource "aws_elb" "coolops_public_elb" {
  name = "coolops-public-elb"


  subnets         = ["subnet-a3716be9","subnet-a3716be9"]
  security_groups = ["${aws_security_group.coolops_webserver_sg.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 10
  }

  instances                   = ["${aws_instance.my-instance.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags {
    Name = "coolops_ELB"
  }
}

output "ELB URL" {
  value = "${aws_elb.coolops_public_elb.dns_name}"
}

output "instance URL" {
  value = "${aws_elb.coolops_public_elb.instances}"
}
