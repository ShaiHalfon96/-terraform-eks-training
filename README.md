# EKS Cluster Implementation

This Terraform configuration deploys an Amazon EKS cluster named `eks-training-cluster` with version `1.30`. The configuration is optimized for a training environment.

## Implementation Details

### Module Source

The EKS cluster is created using a Terraform module sourced from a Git repository:

```
hclCopy code
source = "git@github.com:ShaiHalfon96/terraform-eks-module.git"

```

### Cluster Configuration

- **Cluster Name**: The cluster is named `eks-training-cluster`, making it easy to identify in AWS as part of the training environment.
- **Cluster Version**: Kubernetes version `1.30` is specified to ensure compatibility with desired features and stability.

### Tags

- **Environment Tag**: A tag `Environment = "training"` is applied to all resources created by this module. This helps in organizing and identifying resources associated with the training environment in AWS.

### Security Groups

Custom security groups are defined to manage network traffic to and from the EKS worker nodes.

- **Ingress Rules**:
    - Allows HTTP traffic on port 80 from any IP (`0.0.0.0/0`).
    - Allows HTTPS traffic on port 443 from any IP (`0.0.0.0/0`).
- **Egress Rules**:
    - Allows all outbound traffic from the worker nodes.

### Summary

This setup provides a minimal yet functional EKS cluster tailored for training purposes. The security group configuration ensures that the worker nodes can serve web traffic over HTTP and HTTPS while allowing unrestricted outbound access for updates and other operations. The `Environment` tag helps in managing and identifying resources within AWS.

### To Do List
1. **Set Up DynamoDB for State Management**
*   Create a DynamoDB table to store Terraform state lock information.
*   Configure Terraform backend to use the DynamoDB table for state locking.
    ```hcl
    terraform {
    backend "s3" {
        bucket         = "your-s3-bucket-name"
        key            = "terraform/state/terraform.tfstate"
        region         = "us-west-2"
        dynamodb_table = "terraform-state-lock"
    }
    }
    ```
2. Integrate Atlantis for Terraform Operations

*   Install Atlantis.

*   Configure Atlantis with a atlantis.yaml file for your Terraform projects:

    ```yaml
    version: 3
    projects:
    - name: eks-cluster
        dir: .
        workspace: default
        terraform_version: "1.7.2"
    ```
*   Set up integration with your version control system, GitHub to enable automated Terraform planning and applying through pull requests.