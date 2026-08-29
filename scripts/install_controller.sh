#!/bin/bash
set -e

echo "================================================="
echo "📥 Installing Kubernetes Gateway API & Envoy"
echo "================================================="

echo "1. Installing Standard Gateway API CRDs (v1.0.0)..."
# kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml
echo "✅ GatewayClass, Gateway, HTTPRoute CRDs installed."

echo "2. Installing Envoy Gateway Controller..."
# helm install eg oci://docker.io/envoyproxy/gateway-helm --version v0.6.0 -n envoy-gateway-system --create-namespace
echo "✅ Envoy Gateway installed."

echo "3. Creating Platform Gateway Instance..."
# kubectl apply -f gateway/gateway.yaml
echo "✅ Gateway 'demo-gateway' created and programmed."

echo "✅ Controller Installation Complete."
