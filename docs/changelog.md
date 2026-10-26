# Changelog

## [0.2.1] - 2026-10-27
### Added
- **Declarative GitOps Deployment:** Standardized `deploy/k8s/` base and environment overlays (`dev`, `staging`, `prod`) adhering to CNCF restricted pod security standards (non-root UID 10001, dropped capabilities, read-only rootfs).
- **ArgoCD Continuous Delivery:** Added declarative ArgoCD application manifests (`deploy/argocd/application.yaml`, `application-dev.yaml`, `application-prod.yaml`, `values-override.yaml`).
- **Multi-Cluster Orchestration:** Integrated with `multi-cluster-gitops-promotion` catalog for automated zero-drift self-healing in development/staging and gated PR promotion in production.

## [0.2.0] - 2026-10-20
### Added
- **Multi-Tier Verification:** Staged validation architecture (local static linting, sandbox cluster testing, GitOps production rollout).
- **Supply Chain Security:** Integrated Trivy vulnerability scanning, SPDX JSON SBOM generation, and SHA256 checksums on all release assets.
- **Developer Documentation:** Standardized 3-tier execution instructions and environment configuration templates (`.env.example`).

## [0.1.0] - 2026-10-18
### Added
- Initial catalog release with verified baseline policies, manifests, and automated CI pipelines.

## [2026-08-29] — Phase 2 Evidence
### Added
- Created `scripts/install_controller.sh` and `scripts/conformance_traffic_tests.sh`.
- Standardized documentation (`runbook.md`, `decisions.md`, `ARCHITECTURE.md`).
- Added maturity badge and mock boundaries to `README.md`.


---

## [v0.1.0] — 2026-10-20
### Added
- **Release Automation:** Added `.github/workflows/release.yml` with automated catalog validation, tarball packaging, and SPDX SBOM generation.
- **Supply Chain Security:** Generated Anchore Syft SPDX JSON SBOM and cryptographic SHA-256 checksums.
- **Release Verification:** Added release verification documentation, badges, and operational runbook.
