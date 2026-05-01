# Architecture notes

> These are working notes, not polished documentation. They will evolve as the lab does.

---

## System overview

Three services communicate over HTTP inside a Kubernetes cluster:

```
  [k6 load generator]
         │
         ▼
    [frontend]   ← receives requests, calls backend
         │
         ▼
    [backend]    ← handles business logic, enqueues work
         │
         ▼
    [worker]     ← processes jobs asynchronously
```

None of these services do anything meaningful. The point is the communication pattern:
synchronous calls between frontend and backend, async handoff to the worker. This gives
us a realistic request path to observe and break.

---

## Observability stack

| Component | Role |
|-----------|------|
| Prometheus | Scrapes metrics from services and kube-state-metrics |
| Grafana | Dashboards for metrics |
| Loki | Log aggregation backend |
| Promtail | Log shipping agent (DaemonSet) |

Grafana is the single pane of glass. Metrics and logs are both queryable from there.

---

## What this lab is designed to show

- How latency distributes across a request path
- What error rates look like when one service degrades
- How logs and metrics correlate during a failure
- What a noisy alert looks like vs. a useful one

---

## What this lab does not cover

- Distributed tracing (no Tempo or Jaeger — may add later)
- Real persistent storage
- Multi-node cluster behavior
- Autoscaling
- Proper network policies
- mTLS between services

These are production concerns. Skipping them keeps the lab focused.

---

## Why kind instead of a real cluster

kind runs entirely on your laptop. No cloud costs, no credentials to manage, fast to
create and destroy. The tradeoff is that it hides real-world concerns like node failure,
zone outages, and network partitions. For a local learning lab, that is acceptable.

For a production system on EKS, most of the Kubernetes manifests here would transfer
directly. The observability stack (Prometheus, Grafana, Loki) would typically be replaced
or augmented with managed services or a more robust Helm deployment.

---

## Open questions

- Should the worker pull from a queue (Redis/in-memory) or just receive HTTP calls?
- How much artificial latency should we inject into the backend?
- Do we need a service mesh (Linkerd) for this, or is it overkill for the lab goals?
