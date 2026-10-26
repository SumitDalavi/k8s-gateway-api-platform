# Decisions

## ADR-001: Envoy Gateway for Implementation
**Date:** 2026-08-29  
**Status:** Accepted

**Context:**  
The Gateway API is just a set of CRDs. An implementation (controller) is required to actually route traffic.

**Decision:**  
We selected Envoy Gateway as the reference implementation for local testing.

**Consequences:**  
- ✅ Envoy Gateway natively supports Gateway API out of the box.
- ✅ Envoy is battle-tested.
- ⚠️ Cloud environments (AWS, Azure) will likely use their native Gateway API controllers (e.g. ALB controller) in production.

## ADR-002: Multi-Tier Verification & OCI Dual Distribution
- **Context:** Declarative infrastructure and policy catalogs required robust local simulation gates without imposing cloud provider dependencies or credentials during CI/CD.
- **Decision:** Establish a strict 3-tier verification model (offline linting → sandbox cluster test → GitOps deployment) and distribute validated release packages with SBOMs and OCI container/chart registries.
- **Consequences:** 
  - *Pros:* Zero cloud credentials required for CI validation; verifiable supply-chain integrity via Syft SBOMs.
  - *Cons:* Requires maintaining local test fixtures and mock plan inputs.

## ADR-003: Declarative Multi-Cluster GitOps Packaging with ArgoCD and Kustomize
- **Date:** 2026-10-27
- **Status:** Accepted
- **Context:** Deploying this service across multi-cluster environments (`dev`, `staging`, `prod`) requires a standardized cloud-native packaging format that separates environment-agnostic base specifications from environment-specific resource allocations, replica counts, and security policies without modifying source code or inducing configuration drift.
- **Decision:** Adopt Kustomize overlays under `deploy/k8s/` and declarative ArgoCD `Application` definitions under `deploy/argocd/`.
  1. `deploy/k8s/base`: Declares non-root PodSecurity standards (`runAsUser: 10001`, `drop: [ALL]`, `readOnlyRootFilesystem: true`), probes, and resource constraints without hardcoding namespace.
  2. `deploy/k8s/overlays/{dev,staging,prod}`: Overrides namespace, replica counts, and resources per environment tier.
  3. `deploy/argocd/`: Standalone `Application` CRDs with automated self-healing in `dev`/`staging` and gated PR synchronization in `prod`.
- **Consequences:**
  - *Pros:* Fully declarative, CNCF-compliant, drift-resistant, and natively integrates with the `multi-cluster-gitops-promotion` catalog.
  - *Cons:* Requires maintaining separate overlay directories for each target cluster tier.
