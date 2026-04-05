#!/usr/bin/env bash

set -euo pipefail

if [[ -f configs/.env.example ]]; then
  export $(grep -v '^#' configs/.env.example | xargs)
fi

cd app || exit 1
python -m uvicorn src.main:app --host 0.0.0.0 --port "${SERVICE_PORT:-8000}"
