# python-ci-k8s-iac

This project demonstrates a CI/CD pipeline for a Flask application deployed to Kubernetes on DigitalOcean, using Infrastructure as Code (IaC) with Terraform.

## Project Structure

- `app.py`: Flask application source code.
- `Dockerfile`: Container build instructions.
- `local/`: Local development scripts and Docker Compose.
- `kubernetes/`: Kubernetes manifests for deployment, service, ingress, and configmap.
- `iac/`: Terraform modules and infrastructure definitions.
- `vars/`: Jenkins shared library Groovy scripts.
- `Jenkinsfile`: CI/CD pipeline definition.

## Prerequisites

- Docker & Docker Compose
- Python 3.10+
- Terraform >= 1.13
- DigitalOcean account & API token
- Jenkins (with shared library configured)
- kubectl

## Local Development

1. **Start the app locally with Docker Compose:**
    ```sh
    cd local
    ./start.sh
    ```
    The Flask app will be available at `http://localhost:5000`.

2. **Stop the app:**
    ```sh
    ./stop.sh
    ```

## Infrastructure Provisioning (Terraform)

1. **Initialize Terraform:**
    ```sh
    cd iac/infra
    terraform init
    ```

2. **Apply the infrastructure:**
    ```sh
    terraform apply
    ```
    This will provision a Kubernetes cluster and a container registry on DigitalOcean.

## Kubernetes Deployment

1. **Update the image tag in `kubernetes/deployment.yaml` if needed.**
2. **Apply manifests:**
    ```sh
    kubectl apply -f kubernetes/configmap.yml
    kubectl apply -f kubernetes/service.yaml
    kubectl apply -f kubernetes/ingress.yaml
    kubectl apply -f kubernetes/deployment.yaml
    ```

## CI/CD Pipeline (Jenkins)

- The pipeline defined in [`Jenkinsfile`](Jenkinsfile) will:
    1. Checkout code
    2. Build & push Docker image to DigitalOcean Container Registry
    3. Deploy to Kubernetes (with approval)
    4. Verify deployment
    5. Clean up workspace

## Accessing the Application

- **Local:** `http://localhost:5000`
- **Kubernetes:** Access via the LoadBalancer service or Ingress at `http://test.flaskapptest.run.place` (update DNS as needed).

## Health Check

- `/health` endpoint for liveness probe.