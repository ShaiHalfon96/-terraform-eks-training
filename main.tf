provider "aws" {
  profile = "shai-training"
  region = "eu-north-1"
}

module "eks_cluster" {
  source          = "git@github.com:ShaiHalfon96/terraform-eks-module.git" 

  cluster_name    = "eks-training-cluster"

  cluster_version = "1.30"

  region = "eu-north-1"

  tags = {
    Environment   = "training"
  }

  security_groups = [
    {
      name        = "worker-group-mgmt"
      description = "Security group for worker group"
      ingress = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"  # Allows all outbound traffic
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]
}
