# Runbook — k8s-gateway-api-platform
> Last updated: 2026-08-29

## Quick Start
```bash
# Bring up the cluster and deploy Gateway API and Envoy
kind create cluster --name gateway-lab
bash scripts/install_controller.sh
```

## Run Tests / Demos
```bash
bash scripts/conformance_traffic_tests.sh
```

## Failure Modes
| Symptom | Cause | Fix |
|---|---|---|
| Gateway not Programmed | No controller matches the GatewayClass | Ensure Envoy Gateway is running and GatewayClass is correctly named |
