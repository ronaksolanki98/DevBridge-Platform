#!/usr/bin/env bash
set -euo pipefail

KUBE_CONFIG_PATH=${KUBE_CONFIG_PATH:-"$HOME/.kube/config"}

if [[ ! -f "$KUBE_CONFIG_PATH" ]]; then
  echo "Kubeconfig not found at $KUBE_CONFIG_PATH" >&2
  exit 1
fi

kubectl --kubeconfig "$KUBE_CONFIG_PATH" apply -f kubernetes
