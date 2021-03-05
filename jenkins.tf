# K8s Worker Instances

resource "aws_instance" "jenkins" {
    count = 1
    ami = var.jenkins_ami
    instance_type = var.jenkins_instance_type

    subnet_id = aws_subnet.publicSubnets[count.index].id
    private_ip = cidrhost("${var.public[count.index]}/24", 30 + count.index)
    associate_public_ip_address = true # Instances have public, dynamic IP
    source_dest_check = false # TODO Required??

    availability_zone = "${var.region}${var.az[count.index]}"
    vpc_security_group_ids = [aws_security_group.jenkins-securitygroup.id]
    key_name = var.jenkins_keypair_name

    tags = {
      Name = "jenkins-${count.index}"
      ansibleNodeType = "jenkins"
      ansibleNodeName = "jenkins${count.index}"
    }
}

output "jenkins_public_ip" {
  value = join(",", aws_instance.jenkins.*.public_ip)
}