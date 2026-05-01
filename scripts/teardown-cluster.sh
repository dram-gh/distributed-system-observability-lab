#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="observability-lab"

if ! kind get clusters 2>/dev/null | grep -q "^${CLUSTER_NAME}$"; then
  echo "cluster '${CLUSTER_NAME}' not found, nothing to do"
  exit 0
fi

echo "deleting cluster '${CLUSTER_NAME}'..."
kind delete cluster --name "${CLUSTER_NAME}"
echo "done"
