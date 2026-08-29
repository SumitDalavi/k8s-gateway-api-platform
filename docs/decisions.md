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
