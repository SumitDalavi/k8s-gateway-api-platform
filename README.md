# Gateway API / Modern Kubernetes Traffic Platform 🚦🌐

> Implementing the Kubernetes Gateway API to replace legacy Ingress controllers, demonstrating Role-Oriented traffic management, advanced L7 routing, and traffic splitting.

> **📌 Gateway API Status:** Gateway API graduated to GA (v1.0) in October 2023 and is now the recommended successor to Ingress for new Kubernetes deployments. TLS termination is supported via Gateway listeners with cert-manager integration.

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


## 📋 Prerequisites

| Tool | Version | Purpose |
|------|---------|---------|
| [kubectl](https://kubernetes.io/docs/tasks/tools/) | >= 1.28 | Kubernetes CLI |
| [kind](https://kind.sigs.k8s.io/) or [minikube](https://minikube.sigs.k8s.io/) | Latest | Local K8s cluster |
| [Helm](https://helm.sh/) | >= 3.x | Package manager |

## 🚀 Step-by-Step Setup

### Option A: Local Cluster (kind)

```bash
# 1. Clone the repository
git clone https://github.com/SumitDalavi/k8s-gateway-api-platform.git
cd k8s-gateway-api-platform

# 2. Create a local cluster
kind create cluster --name gateway-lab

# 3. Install Gateway API CRDs
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml

# 4. Install a Gateway API implementation (e.g., Envoy Gateway)
helm install eg oci://docker.io/envoyproxy/gateway-helm --version v0.6.0 -n envoy-gateway-system --create-namespace

# 5. Deploy the Gateway and HTTPRoutes
kubectl apply -f gateway/gateway.yaml
kubectl apply -f routes/http-route-split.yaml
```

### Option B: Existing Cloud Cluster

```bash
kubectl cluster-info
# Follow steps 3-5 from Option A
```

## 🧪 Usage & Demo

### Step 1: Verify the Gateway is provisioned
```bash
kubectl get gateways
kubectl describe gateway demo-gateway
```

### Step 2: Test traffic routing
```bash
# Port-forward the Gateway
kubectl port-forward svc/demo-gateway 8080:80 &

# Send traffic â€” observe routing based on HTTPRoute rules
curl -H "Host: demo.example.com" http://localhost:8080/
curl -H "Host: demo.example.com" http://localhost:8080/api/v2
```

### Step 3: Observe traffic splitting
```bash
# The HTTPRoute splits traffic between v1 and v2 backends
# Send multiple requests and observe different responses
for i in $(seq 1 10); do curl -s -H "Host: demo.example.com" http://localhost:8080/; done
```

## ✅ Verification

| Check | Command | Expected |
|-------|---------|----------|
| CRDs installed | `kubectl get crds \| grep gateway` | Gateway CRDs present |
| Gateway ready | `kubectl get gateways` | Programmed=True |
| Routes active | `kubectl get httproutes` | Accepted=True |
| Traffic flows | `curl -H "Host: demo.example.com" localhost:8080` | Response from backend |

```bash
# Cleanup
kind delete cluster --name gateway-lab
```

## 👨‍💻 Author

**Sumit Dalavi** — Senior DevSecOps / Platform Engineer
[GitHub](https://github.com/SumitDalavi) | [LinkedIn](https://in.linkedin.com/in/sumit-dalavi-762838129)

---

*Built with a focus on production-grade patterns, not toy demos.*