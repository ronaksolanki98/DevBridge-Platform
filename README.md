# DevOps Bridge Platform

![CI](https://img.shields.io/badge/ci-github_actions-blue)
![Infra](https://img.shields.io/badge/infra-terraform-6DB33F)

## Description
DevOps Bridge Platform is a production-grade reference stack that walks through building, testing, packaging, and deploying a Python FastAPI service into Azure using modular Terraform, Docker multi-stage builds, and Kubernetes manifests. It is intentionally minimal to stay approachable while showcasing clean architecture, separation of concerns, and CI/CD best practices that real teams ship every day.

### Features
- FastAPI service with health/info endpoints and Pydantic-backed configuration
- Docker multi-stage build + docker-compose for local development
- Helm-free Kubernetes manifests (Deployment + Service) guarded by readiness/liveness probes
- Terraform modules for resource group, VNet, storage, Key Vault, and App Service with tagging and secrets hygiene
- GitHub Actions pipeline with test → image build/push → Kubernetes deployment stages
- Scripts for local bootstrapping (`scripts/run-local.sh`, `scripts/run-tests.sh`)

## Badges
See the shields above for workflow and tooling status (link them as you hook up actual pipelines).

## Visuals
A simple architecture diagram is described in [docs/architecture.md](docs/architecture.md) and explains the flow: Developer commits → GitHub Actions runs tests/build/push → Kubernetes deployment consumes the image and Terraform-managed infrastructure.

## Installation
1. Clone the repo.
2. Copy `configs/.env.example` to `.env` and adjust values when needed.
3. Create a Python virtual environment: `python -m venv .venv && source .venv/bin/activate`.
4. Install dependencies: `pip install -r app/requirements.txt`.
5. (Optional) Build the Docker image: `docker build -f docker/Dockerfile -t devops-bridge .`.
6. (Optional) Run locally: `./scripts/run-local.sh`.

## Usage
- Access `http://localhost:8000/health` or `/info` when the service is running locally or inside Kubernetes.
- Exercises such as `./scripts/run-tests.sh` keep the service regression-free.
- Terraform lives under `infrastructure/terraform`; follow [docs/setup.md](docs/setup.md) for provisioning guidance.

## Support
Open issues or pull requests directly in this repository. Include logs/output from `scripts/run-local.sh`, `./scripts/run-tests.sh`, or `terraform plan` to accelerate triage.

## Roadmap
1. Chaotic deployment matrix (dev/staging/prod) via overlays or Helm.
2. Automatic secrets injection from Key Vault/App Service identity.
3. Monitoring/alerting integration (Prometheus/Grafana or Azure Monitor).
4. End-to-end smoke tests that run post-deployment.

## Contributing
1. Fork the repo and create a branch (e.g., `feature/your-change`).
2. Run `./scripts/run-tests.sh` locally before opening a PR.
3. Update documentation under `docs/` and `README.md` when introducing new behavior.
4. Keep Terraform module changes isolated and documented via `modules/<name>` readme notes.

## Authors and Acknowledgment
- Original author: this DevOps reference builder.
- Inspired by Real-World Infrastructure and GitHub Actions best practices.

## License
This repository ships under the [MIT License](LICENSE) (create the file if you wish to open-source it).

## Project Status
Active development — aim to keep the project polished and documented before presenting it to stakeholders. Feedback and contributions are welcome.
