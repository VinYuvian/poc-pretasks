variable "vpc_cidr"{
    default = "192.168.0.0"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "kubernetes.pub"
}

variable "project"{
    default = "project"
}

variable "vpc_name"{
    default = "kubernetes-vpc"
}

variable "region"{
    default="ap-south-1"
}

variable "az"{
    default=["a","b"]
}

variable "public"{
    default = ["192.168.1.0","192.168.3.0"]
}

variable "private"{
    default = ["192.168.2.0","192.168.4.0"]
}

variable "jenkins_instance_type"{
    default = "t2.medium"
}


variable "elk_instance_type"{
    default = "t2.small"
}

variable "jenkins_ami"{
    default = "ami-03b0e617e9f3b045b"
}

variable "elk_ami"{
    default = "ami-08410e5404d2d6588"
}

variable "default_keypair_name"{
    default = "kubernetes"
}

variable "elk_keypair_name"{
    default = "elk-demo"
}

variable "jenkins_keypair_name"{
    default = "jenkins_demo"
}