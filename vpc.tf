# PROVIDER 

provider "aws"{
    profile = "kubernetes"
    region = "ap-south-1"
}

# VPC
resource "aws_vpc" "vpc"{
    cidr_block = "${var.vpc_cidr}/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags={
        Name = var.vpc_name
    }
}

# SUBNETS
resource "aws_subnet" "privateSubnets"{
	vpc_id=aws_vpc.vpc.id
	#count=3
    count = length(var.private)
    cidr_block= "${var.private[count.index]}/24"
	availability_zone="${var.region}${var.az[count.index]}"
	tags={
		Name="privateSubnet-${count.index}"
        Tier="Private"
	}
}

resource "aws_subnet" "publicSubnets"{
	vpc_id=aws_vpc.vpc.id
	count = length(var.public)
	cidr_block= "${var.public[count.index]}/24"
    map_public_ip_on_launch="true"
	availability_zone="${var.region}${var.az[count.index]}"
	tags={
		Name="PublicSubnet-${count.index}"
        Tier="public"
	}
}

# ROUTING

resource "aws_route_table" "pvt_rtable"{
    vpc_id = aws_vpc.vpc.id 
    tags={
        Name = "private"
    }
}

resource "aws_route_table_association" "pvtassn"{
    count = length(aws_subnet.privateSubnets)
    subnet_id = aws_subnet.privateSubnets[count.index].id 
    route_table_id = aws_route_table.pvt_rtable.id
}

resource "aws_route_table" "public_rtable"{
    vpc_id = aws_vpc.vpc.id 
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags={
        Name = "public"
    }
}

resource "aws_route_table_association" "publicassn"{
    count = length(aws_subnet.publicSubnets)
    subnet_id = aws_subnet.publicSubnets[count.index].id
    route_table_id = aws_route_table.public_rtable.id
}

#GATEWAYS

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.vpc.id
    tags={
        Name = format("%s-igw",var.project)
    }
}







