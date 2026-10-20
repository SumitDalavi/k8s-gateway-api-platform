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


---

## Release Runbook

### Release Trigger
Tag push matching `v*.*.*` (e.g., `v0.1.0`).

### Automated Pipeline Stages
1. **Quality & Validation Gate:** Validates policy syntax, Rego rules, and manifest schemas.
2. **Distribution Packaging:** Bundles clean production manifests into `k8s-gateway-api-platform-<tag>.tar.gz` and calculates SHA256 checksums.
3. **Syft Source SBOM:** Generates `sbom.spdx.json` adhering to SPDX 2.3 standard.
4. **GitHub Release:** Publishes release assets and release notes.

### Verification
```bash
gh release view v0.1.0 --repo SumitDalavi/k8s-gateway-api-platform
gh release download v0.1.0 --repo SumitDalavi/k8s-gateway-api-platform --pattern "checksums.txt"
```

### Failure Modes & Remediation
- **Linter / Test Failure:** Inspect policy syntax or module arguments locally before tagging.
- **Checksum Mismatch:** Ensure file was completely downloaded without network truncation.
