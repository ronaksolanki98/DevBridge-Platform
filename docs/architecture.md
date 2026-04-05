# Architecture Overview

The repository divides responsibilities across clear lanes: the **application** (Python / FastAPI service), the **infrastructure** (IaC on Azure via Terraform modules), and the **operations**/CI/CD artifacts that deliver the application to production-grade targets.

## Layers
1. **Application**: FastAPI exposes `/health` and `/info` and is configurable via Pydantic-backed environment values. Dockerizes through a multi-stage image and is validated with Pytest along with GitHub Actions.
2. **Infrastructure**: Terraform root composes reusable modules for resource groups, networking, storage, Key Vault, and App Service, encouraging idempotency, tagging, and least-privilege access policies.
3. **Operations**: CI/CD lives in `.github/workflows/ci.yml` with separate jobs for testing, Docker build/publish, and Kubernetes deployment.

## Flow
```
Developer -> Git (GitHub) -> GitHub Actions -> Unit tests & security checks -> Docker image build & push -> kubectl + manifests -> Kubernetes cluster
```
Every merge triggers lint/test, gates image promotion, and only then walls to deployment.

## Scalability & Modularity
- Each Terraform module focuses on a single concern and accepts configurable inputs such as SKU, tags, or secrets placeholders.
- Kubernetes manifests are declarative clusters (Deployment + Service) ready for horizontal autoscaling.
- Docker image supports multi-platform builds so both amd64 and arm64 hosts can pull the same artifact.
