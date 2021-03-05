# K8s Worker Instances

resource "aws_instance" "elk" {
    count = 1
    ami = var.elk_ami
    instance_type = var.elk_instance_type

    subnet_id = aws_subnet.publicSubnets[count.index].id
    //private_ip = "192.168.1.40"
    private_ip = cidrhost("${var.public[count.index]}/24", 40 + count.index)
    associate_public_ip_address = true # Instances have public, dynamic IP
    source_dest_check = false # TODO Required??

    availability_zone = "${var.region}${var.az[count.index]}"
    vpc_security_group_ids = [aws_security_group.elk-securitygroup.id]
    key_name = var.elk_keypair_name

    tags = {
      Name = "elk-${count.index}"
      ansibleNodeType = "elk"
      ansibleNodeName = "elk${count.index}"
    }
}

output "elk_public_ip" {
  value = join(",", aws_instance.elk.*.public_ip)
}