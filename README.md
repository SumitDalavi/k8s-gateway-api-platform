# Gateway API / Modern Kubernetes Traffic Platform 🚦🌐

> Implementing the Kubernetes Gateway API to replace legacy Ingress controllers, demonstrating Role-Oriented traffic management, advanced L7 routing, and traffic splitting.

## The Problem

The original Kubernetes `Ingress` API is fundamentally flawed for large organizations. It forces Platform Teams and Application Developers to fight over the same YAML file, relying on messy, non-standard annotations (like `nginx.ingress.kubernetes.io/rewrite-target`) to accomplish basic L7 routing. It provides no clear separation of duties.

## The Solution

This project implements the modern **Kubernetes Gateway API** (the official successor to Ingress). 

It divides traffic management into distinct, role-based CRDs:
1. **GatewayClass**: Defined by the Infrastructure Provider (e.g., Azure, AWS).
2. **Gateway**: Defined by the Platform Team to provision load balancers and listen on specific ports/domains.
3. **HTTPRoute**: Defined by the Application Developers to attach their microservices to the Gateway and manage traffic splitting, header manipulation, and path rewrites.

## Why This Over the Obvious Alternative

The alternative is continuing to use NGINX Ingress and relying on hundreds of brittle string annotations. The Gateway API is strongly typed, portable across cloud providers, and native to Kubernetes. By demonstrating this, you signal that you are designing networks for *tomorrow's* Kubernetes architecture, not just maintaining yesterday's legacy clusters.

## 🛠️ Tech Stack

- **Traffic Specification**: Kubernetes Gateway API v1
- **Implementer**: Envoy Gateway (or similar compliant controller)

## Decision Log

| Decision | Rationale |
|----------|-----------|
| Gateway API over Ingress | Gateway API is GA (General Availability) and is the official standard moving forward. It provides advanced traffic splitting natively without needing a service mesh like Istio. |
| Role-Oriented Design | By splitting the `Gateway` (managed by Platform) and `HTTPRoute` (managed by Devs in a separate namespace), we adhere to the principle of least privilege. |

## 📁 Project Structure

```
├── gateway/
│   └── gateway.yaml           # Platform Team: provisions the Load Balancer
├── routes/
│   └── http-route-split.yaml  # App Team: routes traffic and performs A/B splits
├── docs/ARCHITECTURE.md
└── README.md
```

## 👨‍💻 Author

*Built to demonstrate modern L7 networking, API design, and role-based cluster management.*
