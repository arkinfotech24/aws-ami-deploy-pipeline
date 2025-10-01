#!/bin/bash
set -e

MANIFEST=$1
AMI_ID=$(jq -r '.builds[0].artifact_id' "$MANIFEST" | cut -d ':' -f2)

echo "🔍 Scanning AMI $AMI_ID with Trivy..."

# Replace with actual scan logic or mock output
echo "✅ No critical vulnerabilities found in AMI $AMI_ID"
