# AWS Containers Retail Sample

This is a sample application designed to illustrate various concepts related to containers on AWS. It presents a sample retail store application including a product catalog, shopping cart and checkout.

It provides:
- A distributed component architecture in various languages and frameworks
- Utilization of a variety of different persistence backends for different components like MySQL, DynamoDB and Redis
- The ability to run in various container orchestration technologies like Docker Compose, Kubernetes etc.
- Pre-built containers image for both x86-64 and ARM64 CPU architectures
- All components instrumented for Prometheus metrics and OpenTelemetry OTLP tracing
- Support for Istio on Kubernetes
- Load generator which exercises all of the infrastructure

**This project is intended for educational purposes only and not for production use.**

![Screenshot](/retail-store-sample-app/docs/images/screenshot.png)

## Application Architecture

The application has been deliberately over-engineered to generate multiple de-coupled components. These components generally have different infrastructure dependencies, and may support multiple "backends" (example: Carts service supports MongoDB or DynamoDB).

![Architecture](/retail-store-sample-app/docs/images/architecture.png)

| Component | Language | Container Image     | Description                                                                 |
|-----------|----------|---------------------|-----------------------------------------------------------------------------|
| ![ui workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-ui.yml/badge.svg)        | Java     | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-ui)       | Aggregates API calls to the various other services and renders the HTML UI. |
| ![catalog workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-catalog.yml/badge.svg)   | Go       | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-catalog)  | Product catalog API                                                         |
| ![cart workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-cart.yml/badge.svg)   | Java     | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-cart)     | User shopping carts API                                                     |
| ![orders workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-orders.yml/badge.svg)  | Java     | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-orders)   | User orders API                                                             |
| ![checkout workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-checkout.yml/badge.svg) | Node     | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-checkout) | API to orchestrate the checkout process                                     |
| ![assets workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-assets.yml/badge.svg)  | Nginx    | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-assets)   | Serves static assets like images related to the product catalog             |

## Quickstart
The steps and commands to deploy an AWS EKS cluster using the `terraform-aws-modules/eks/aws` module from Terraform.
Cloning a repository that includes both Terraform configuration files and the application code, setting up AWS credentials, applying the infrastructure, deploying Kubernetes resources using `kubectl`, and the prerequisites needed.

# Deploying AWS EKS Cluster with Terraform

This guide details the steps to deploy an AWS EKS cluster using Terraform and then deploy a Kubernetes application.

## Prerequisites

Before starting, ensure you have the following installed:
- **Terraform**: [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- **kubectl**: [Install kubectl](https://kubernetes.io/docs/tasks/tools/)
- **AWS CLI**: [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Configure AWS CLI with your credentials (`aws configure`).

## Repository Setup

1. **Clone the Repository**:
   Clone the repository that contains both the Terraform configurations and the application code.
   ```bash
   git clone https://github.com/HILL-TOPCONSULTANCY/retail-store.git
   cd retail-store/terraform
   ```

2. **Initialize Terraform**:
   Initialize a working directory containing Terraform configuration files.
   ```bash
   terraform init
   ```

## Deploying the Infrastructure

1. **Create AWS Credentials**:
   Ensure your AWS credentials are set up. This can be done by generating aws access keys and parsing them below `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`.
   ```bash
   aws configure
   ```

2. **Create a Terraform Plan**:
   Generate and show an execution plan, describing what actions Terraform will take to change the infrastructure to match the configuration.
   ```bash
   terraform plan
   ```

3. **Apply the Terraform Configuration**:
   Apply the changes required to reach the desired state of the configuration.
   ```bash
   terraform apply
   ```

## Configuring kubectl to Connect to Your Cluster

1. **Update kubeconfig**:
   After the cluster is created, configure `kubectl` to connect to your new AWS EKS cluster.
   ```bash
   aws eks --region us-east-1 update-kubeconfig --name eks-hilltop
   ```

## Deploying Kubernetes Resources

1. **Deploy the Application**:
   Apply the Kubernetes YAML files to deploy your application.
   ```bash
   kubectl apply -f retail-store-sample-app/main/dist/kubernetes/deploy.yaml
   kubectl wait --for=condition=available deployments --all
   ```
2. **Verify the Application**:
   Verify that the application is running by checking the status of the pods.
   ```bash
   kubectl get pods
   ```
3. **Access the Application**:
   Access the application by opening the URL in your browser.
   ```bash
   kubectl get svc ui
   ```

## Cleanup

1. **Destroy the Infrastructure**:
   If you need to remove all resources created by Terraform.
   ```bash
   terraform destroy
   ```

# Docker Compose

This deployment method will run the application on your local machine using `docker-compose`, and will build the containers as part of the deployment.

Pre-requisites:
- Docker installed locally

Change directory to the Docker Compose deploy directory:

```
cd dist/docker-compose
```

Use `docker compose` to run the application containers:

```
MYSQL_PASSWORD='<some password>' docker compose --file dist/docker-compose/docker-compose.yml up
```

Open the frontend in a browser window:

```
http://localhost:8888
```

To stop the containers in `docker compose` use Ctrl+C. To delete all the containers and related resources run:

```
docker compose -f dist/docker-compose/docker-compose.yml down
```

### Additional Notes:
- The AWS region and cluster name in the `kubectl` configuration step need to be replaced with the actual values you used during the Terraform setup.
- Ensure the AWS credentials provided have the necessary permissions to create an EKS cluster and manage related resources.
- The path `<path-to-your-kubernetes-yaml>` should be the actual path to your Kubernetes application's YAML configuration files within the cloned repository.

