resource "aws_security_group" "jenkins-securitygroup" {
  vpc_id = aws_vpc.vpc.id
  name = "jenkins-securitygroup"
  description = "security group that allows ssh and all egress traffic"

  tags = {
    Name = "jenkins-securitygroup"
  }
}

resource "aws_security_group_rule" "allow_ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_group_id = aws_security_group.jenkins-securitygroup.id
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_some_jenkins_access" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_group_id = aws_security_group.jenkins-securitygroup.id
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_jnlp_access" {
    type = "ingress"
    from_port = 50000
    to_port = 50000
    protocol = "tcp"
    security_group_id = aws_security_group.jenkins-securitygroup.id
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_outgoing_traffic" {
    type = "egress"
    from_port = 0
    to_port = 65535
    protocol = "-1"
    security_group_id = aws_security_group.jenkins-securitygroup.id
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "elk-securitygroup" {
  vpc_id = aws_vpc.vpc.id
  name = "elk-securitygroup"
  description = "security group that allows ssh and all egress traffic"

  tags = {
    Name = "elk-securitygroup"
  }
}

resource "aws_security_group_rule" "elk_allow_ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_group_id = aws_security_group.elk-securitygroup.id
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elk_allow_5601" {
    type = "ingress"
    from_port = 5601
    to_port = 5601
    protocol = "tcp"
    security_group_id = aws_security_group.elk-securitygroup.id
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elk_allow_9200" {
    type = "ingress"
    from_port = 9200
    to_port = 9200
    protocol = "tcp"
    security_group_id = aws_security_group.elk-securitygroup.id
    cidr_blocks = ["0.0.0.0/0"]
}