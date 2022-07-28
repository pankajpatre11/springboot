resource "aws_vpc" "vpc_2" {
  enable_dns_support  = true
  enable_dns_hostnames  = true
  cidr_block  = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block  = false

  tags = {
    env  = "Development"
    archUUID  = "c7830239-5868-4a05-8a8f-81a654133555"
  }
}

resource "aws_subnet" "subnet_4" {
  vpc_id  = aws_vpc.vpc_2.id
  availability_zone  = "us-east-1a"

  tags = {
    env  = "Development"
    archUUID  = "c7830239-5868-4a05-8a8f-81a654133555"
  }
}

resource "aws_subnet" "subnet_5" {
  vpc_id  = aws_vpc.vpc_2.id
  availability_zone  = "us-east-1b"

  tags = {
    env  = "Development"
    archUUID  = "c7830239-5868-4a05-8a8f-81a654133555"
  }
}

resource "aws_security_group" "security_group_6" {
  vpc_id  = aws_vpc.vpc_2.id
  description  = "kube_sg"

  egress {
    to_port  = 0
    protocol  = "-1"
    from_port  = 0
    cidr_blocks = [
      "0.0.0.0.0/0",
    ]
  }

  ingress {
    to_port  = 443
    protocol  = "tcp"
    from_port  = 443
  }

  tags = {
    env  = "Development"
    archUUID  = "c7830239-5868-4a05-8a8f-81a654133555"
  }
}

resource "aws_eks_cluster" "eks_cluster_7" {
  role_arn  = aws_iam_role.iam_role_13_c_c.arn

  tags = {
    env  = "Development"
    archUUID  = "c7830239-5868-4a05-8a8f-81a654133555"
  }

  vpc_config {
    security_group_ids = [
      aws_security_group.security_group_6.id,
    ]
    subnet_ids = [
      aws_subnet.subnet_4.id,
      aws_subnet.subnet_5.id,
    ]
  }
}

resource "aws_eks_node_group" "aws_eks_node_group" {

  tags = {
    env  = "Development"
    archUUID  = "c7830239-5868-4a05-8a8f-81a654133555"
  }
}

resource "aws_internet_gateway" "internet_gateway_9" {
  vpc_id  = aws_vpc.vpc_2.id

  tags = {
    env  = "Development"
    archUUID  = "c7830239-5868-4a05-8a8f-81a654133555"
  }
}

resource "aws_default_route_table" "default_route_table_10" {

  route {
    gateway_id  = aws_internet_gateway.internet_gateway_9.id
    cidr_block  = "0.0.0.0/0"
  }

  tags = {
    env  = "Development"
    archUUID  = "c7830239-5868-4a05-8a8f-81a654133555"
  }
}

resource "aws_route_table_association" "route_table_association_11" {
  subnet_id  = aws_subnet.subnet_4.id
  route_table_id  = aws_default_route_table.default_route_table_10.id
}

resource "aws_route_table_association" "route_table_association_12" {
  subnet_id  = aws_subnet.subnet_5.id
  route_table_id  = aws_default_route_table.default_route_table_10.id
}

resource "aws_iam_role" "iam_role_13" {
  assume_role_policy  = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}    
POLICY 

  tags = {
    env  = "Development"
    archUUID  = "c7830239-5868-4a05-8a8f-81a654133555"
  }
}

resource "aws_iam_role" "iam_role_13_c_c" {
  assume_role_policy  = "**POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}    
POLICY"

  tags = {
    env  = "Development"
    archUUID  = "c7830239-5868-4a05-8a8f-81a654133555"
  }
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_14_c_c" {
  role  = aws_iam_role.iam_role_13.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_14" {
  role  = aws_iam_role.iam_role_13.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_14_c" {
  role  = aws_iam_role.iam_role_13.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy" "aws_iam_role.iam_role_13_c_c.name" {
  role  = aws_iam_role_policy
  policy  = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role_policy" "aws_iam_role.iam_role_13_c_c.name_c" {
  role  = aws_iam_role_policy
  policy  = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

