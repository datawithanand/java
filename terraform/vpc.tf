resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "eks_subnets" {
  count = 2
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = element(["10.0.1.0/24", "10.0.2.0/24"], count.index)
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  
  # Required for EKS
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/role/elb" = "1"
  }
}
