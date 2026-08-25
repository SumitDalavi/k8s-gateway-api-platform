#!/bin/bash
set -e

echo "Running Conftest on Gateway API manifests..."
docker run --rm -v $(pwd):/project openpolicyagent/conftest test /project/routes/ -p /project/policies/

echo "✅ Gateway API manifests pass structural policy checks!"
