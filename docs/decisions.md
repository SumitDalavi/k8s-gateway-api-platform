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
