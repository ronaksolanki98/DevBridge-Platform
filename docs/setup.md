# Setup Guide

## Prerequisites
- Docker 24+ and docker-compose
- Terraform 1.5+
- Python 3.12
- kubectl (for deployment)

## Local setup
1. Copy the env template: `cp configs/.env.example .env` and adjust values when necessary.
2. Create a virtualenv from repo root: `python -m venv .venv && source .venv/bin/activate`.
3. Install app dependencies: `pip install -r app/requirements.txt`.
4. Run the service: `scripts/run-local.sh`.

## Running tests
```
./scripts/run-tests.sh
```

## Terraform
1. Populate `infrastructure/terraform/terraform.tfvars` (copy from `.example`).
2. `cd infrastructure/terraform` and run `terraform init`.
3. Use `terraform plan` and `terraform apply` for provisioning.
4. `terraform destroy` when tearing down.

## Kubernetes
1. Update `kubernetes/deployment.yaml` image tag to the pushed artifact.
2. Apply manifests with `kubectl apply -f kubernetes`.
