# EKS Cluster Outputs
output "cluster-id" {
  description = "The name/id of the EKS cluster."
  value       = aws_eks_cluster.eks-cluster.id
}

output "cluster-arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = aws_eks_cluster.eks-cluster.arn
}

output "cluster-endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = aws_eks_cluster.eks-cluster.endpoint
}

output "cluster-version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = aws_eks_cluster.eks-cluster.version
}

output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster."
  value       = aws_iam_role.eks-master-role.name 
}

output "cluster_iam_role_arn" {
  description = "IAM role ARN of the EKS cluster."
  value       = aws_iam_role.eks-master-role.arn
}

# EKS Node Group Outputs - Public
output "node_group_public_id" {
  description = "Public Node Group ID"
  value       = aws_eks_node_group.eks-ng-public.id
}

output "node_group_public_arn" {
  description = "Public Node Group ARN"
  value       = aws_eks_node_group.eks-ng-public.arn
}

output "node_group_public_status" {
  description = "Public Node Group status"
  value       = aws_eks_node_group.eks-ng-public.status 
}

output "node_group_public_version" {
  description = "Public Node Group Kubernetes Version"
  value       = aws_eks_node_group.eks-ng-public.version
}
