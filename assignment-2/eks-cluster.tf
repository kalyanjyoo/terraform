# Create AWS EKS Cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = "${local.name}-${var.cluster-name}"
  role_arn = aws_iam_role.eks-master-role.arn
  
  vpc_config {
    subnet_ids = [
        aws_subnet.private-subnet-1a.id,
        aws_subnet.private-subnet-1b.id,
        aws_subnet.public-subnet-1a.id,
        aws_subnet.public-subnet-1b.id
    ]  
  }

  depends_on = [aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy]
}
