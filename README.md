# Cloud setup overview
This guide covers the setup and deployment of infrastructure on [AWS](https://aws.amazon.com/) and [Azure](https://azure.microsoft.com/) using Terraform, </br>
including the deployment of [Kubernetes](https://kubernetes.io/) clusters and Ingress controllers (ALB and Application Gateway). <br />
Additionally, it provides instructions to deploy a [Python Flask](https://flask.palletsprojects.com/en/3.0.x/) "Hello World" application using Helm.

### Prerequisites
- [Terraform](https://www.terraform.io/) installed on your local machine.
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured with appropriate permissions.
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) configured with appropriate permissions.
- [kubectl](https://kubernetes.io/docs/tasks/tools/) installed and configured for managing Kubernetes clusters.
- [Helm](https://helm.sh/docs/intro/install/) installed on your local machine.
- [Docker](https://www.docker.com/) installed on your local machine.


### AWS Setup
1. **Configure AWS CLI** </br>
Ensure your AWS CLI is configured properly. You need to have credentials and configure your CLI using the following command:
```
aws configure
```
2. **Terraform Configuration for AWS**  </br>
You can change aws profile name in the terraform provider config
```
provider "aws" {
  profile = "your-aws-profile"
  region  = "us-east-1"
}
```
Also, you should have S3 backet for storing state file
```
terraform {
  backend "s3" {
    bucket = "your-s3-bucket"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}
```
3. **Initialize and Apply Terraform**  </br>
``` 
terraform init
terraform apply
```
4. **Configure kubectl for EKS**
```
aws eks update-kubeconfig --name EKS-cloud-setup-cluster --region us-east-1 --profile your-aws-profile
```
5. **Install NGINX Ingress Controller on AWS** </br>
Update a ***eks/k8s/ingress-controller/values.yaml*** file for the NGINX Ingress Controller. </br>
Please add values of public subnets which you'll get in terraform output:
```
controller:
  service:
    annotations:
      service.beta.kubernetes.io/aws-load-balancer-type: "alb"
      service.beta.kubernetes.io/aws-load-balancer-subnets: "" # Need to add subnets id's
      alb.ingress.kubernetes.io/scheme: internet-facing
      alb.ingress.kubernetes.io/target-type: ip
  ingressClassResource:
    name: "nginx"
    enabled: true
    default: true
```
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace -f values.yaml
```

### Azure Setup
1. **Configure Azure CLI**
Ensure your Azure CLI is configured properly:
```
az login
```
2. **Specify you storage account for keeping state file**
```
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "yourstorageaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
```
3.  **Initialize and Apply Terraform**
```
terraform init
terraform apply
```
4. **Configure kubectl for AKS**
```
az aks get-credentials --resource-group aks-rg --name AKS-cloud-setup--cluster
```
5. **Install Application Gateway Ingress Controller on Azure**
Update a ***aks/k8s/ingress-controller/values.yaml*** file for the NGINX Ingress Controller. </br>
```
appgw:
  name: "appgw"
  resourceGroup: "aks-rg"
  subscriptionId: "your-subscription-id"
  shared: false

armAuth:
  type: managed
  identityClientID: "your-identity-client-id"

rbac:
  enabled: true

verbosityLevel: 3
```
Install the Ingress Controller:
```
helm repo add application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/
helm repo update
helm install agic application-gateway-kubernetes-ingress/ingress-azure --namespace application-gateway --create-namespace -f values.yaml
```
### Deploy Hello World Application
1. **Build and Push Docker Image**
Navigate to the directory containing your Flask application and build the Docker image:
```
docker build -t your-dockerhub-username/hello-world:latest .
```
Push the Docker image to Docker Hub:
```
docker push your-dockerhub-username/hello-world:latest
```
2. **Helm Chart for Hello World Application**
Ensure your Helm chart for the Hello World application is configured properly. You can customize values in </br>
***aks/k8s/app/values.yaml***
***eks/k8s/app/values.yaml***
3. **Deploy Hello World Application using Helm**
Deploy the application to the cluster:
```
helm install hello-world-demo ./path-to-your-helm-chart --namespace default --create-namespace
```
### Verify Installation
#### Verify NGINX Ingress Controller on AWS
Check the status of the NGINX Ingress Controller:
```
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
```
#### Verify Application Gateway Ingress Controller on Azure
Check the status of the Application Gateway Ingress Controller:
```
kubectl get pods -n application-gateway
kubectl get svc -n application-gateway
```
#### Verify Hello World Application
Check the status of the Hello World application:
```
kubectl get pods -n default
kubectl get svc -n default
kubectl get ingress -n default
```
#### Ensure that the Ingress controller has created the necessary resources and that the application is accessible via the external IP or DNS.

