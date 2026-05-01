# distributed-system-observability-lab

A local Kubernetes lab to explore observability and failure behaviour in a small multi-service system, focusing on metrics, log aggregation, and controlled failure injection.

This is a learning and portfolio project. It is not production-ready.

---

## What this is

A simple multi-service application running on a local kind cluster, instrumented with Prometheus, Grafana, and Loki. The setup includes load testing and deliberate failure scenarios to observe how the system behaves under load, latency, and partial failures.

The application itself is intentionally minimal. The focus is on the observability layer and the kinds of questions it helps answer:

- Where is latency coming from?
- Which service is failing or slowing down?
- How do errors propagate across services?
- What early signals appear before a visible failure?

---

## Status

| Milestone | Description | Status |
|-----------|-------------|--------|
| 1 | Repo structure and docs skeleton | ✅ Done |
| 2 | kind cluster, namespace, cluster config | Planned |
| 3 | Core services (frontend, backend, worker) | Planned |
| 4 | Prometheus + Grafana | Planned |
| 5 | Loki + Promtail log aggregation | Planned |
| 6 | k6 load testing | Planned |
| 7 | Failure injection and alerting | Planned |

---

## Prerequisites

- Docker Desktop or Docker Engine (tested with 24.x)
- [kind](https://kind.sigs.k8s.io/) v0.22+
- kubectl
- Helm v3.x
- [k6](https://k6.io/)

---

## Layout

```
services/         application code for each service
k8s/              Kubernetes manifests
observability/    Prometheus, Grafana, and Loki configuration
load-testing/     k6 scripts
scripts/          cluster bootstrap and teardown helpers
docs/             architecture notes and decision records
```

---

## Limitations

This runs on a single local machine with a single-node kind cluster. That means:

- No real high availability
- Persistent storage is ephemeral by default
- RBAC is simplified
- Network policies are not enforced

See [docs/architecture.md](docs/architecture.md) for more detail on what this setup demonstrates and what it intentionally leaves out.


---

## Running it

TODO
