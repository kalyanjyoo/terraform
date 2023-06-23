# Create AWS EKS Node Group - Private
resource "aws_eks_node_group" "eks-ng-private" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-ng-private"
  node_role_arn   = aws_iam_role.eks-nodegroup-role.arn

  subnet_ids = [
    aws_subnet.private-subnet-1a.id,
    aws_subnet.private-subnet-1b.id
  ]

  capacity_type = "ON_DEMAND"
  instance_types = ["t2.medium"]
  ami_type = "AL2_x86_64"  
  disk_size = 20

  scaling_config {
    desired_size = 1
    min_size     = 1    
    max_size     = 3
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1    
  }

    depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  ] 
   
  tags = {
    Name = "Private-Node-Group"
  }

}
