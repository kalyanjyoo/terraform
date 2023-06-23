# Create AWS EKS Cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = "${local.name}-${var.cluster-name}"
  role_arn = aws_iam_role.eks-master-role.arn
  version = "${var.cluster_version}"
  
  vpc_config {
    subnet_ids = [
        aws_subnet.private-subnet-1a.id,
        aws_subnet.private-subnet-1b.id,
        aws_subnet.public-subnet-1a.id,
        aws_subnet.public-subnet-1b.id
    ]
    endpoint_endpoint_private_access = "${var.cluster-endpoint-private-access}"
    endpoint_public_access = "${var.cluster-endpoint-public-acess}"
    public_access_cidrs = "${var.cluster-endpoint-public-access-cidrs}"
  }

  # Enable EKS Cluster Control Plane Logging
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy]
}
