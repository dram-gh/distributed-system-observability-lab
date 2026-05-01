#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="observability-lab"
NAMESPACE="observability-lab"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

check_prereqs() {
  for cmd in kind kubectl; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "error: $cmd is not installed or not in PATH"
      exit 1
    fi
  done
}

create_cluster() {
  if kind get clusters 2>/dev/null | grep -q "^${CLUSTER_NAME}$"; then
    echo "cluster '${CLUSTER_NAME}' already exists, skipping"
  else
    echo "creating cluster '${CLUSTER_NAME}'..."
    kind create cluster --config "${ROOT_DIR}/kind-config.yaml"
  fi
}

apply_namespace() {
  echo "applying namespace '${NAMESPACE}'..."
  kubectl apply -f "${ROOT_DIR}/k8s/namespace.yaml"
}

check_prereqs
create_cluster
apply_namespace

echo ""
echo "ready. verify with:"
echo "  kubectl get nodes"
echo "  kubectl get ns ${NAMESPACE}"
