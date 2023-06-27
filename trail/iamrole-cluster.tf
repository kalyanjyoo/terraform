# Create IAM Role for eks master
resource "aws_iam_role" "eks-master-role" {
  name = "${var.iamrole-cluster}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

# Associate IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-master-role.name
}

