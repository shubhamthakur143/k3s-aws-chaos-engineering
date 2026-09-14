#!/bin/bash

set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RESULT_DIR="$SCRIPT_DIR/../results"
RESULT_FILE="$RESULT_DIR/01-blob-deletion-chaos-result.txt"

CONTAINER="chaoscontainer01"
BLOB="application-config.txt"
CONTENT="Important Azure application configuration"

mkdir -p "$RESULT_DIR"

exec > >(tee "$RESULT_FILE") 2>&1

echo "============================================"
echo "AZURE CHAOS #1 - BLOB DELETION"
echo "============================================"

echo
echo "[1] ENVIRONMENT SETUP"

eval $(floci az env)

echo "Azure Storage Endpoint:"
echo "$AZURE_STORAGE_CONNECTION_STRING"

echo
echo "[2] CLEANUP PREVIOUS RESOURCES"

az storage container delete \
  --name "$CONTAINER" \
  --connection-string "$AZURE_STORAGE_CONNECTION_STRING" \
  --yes 2>/dev/null || true

rm -f "$BLOB" baseline.txt after-chaos.txt recovered.txt

echo
echo "[3] BASELINE - CREATE CONTAINER"

az storage container create \
  --name "$CONTAINER" \
  --connection-string "$AZURE_STORAGE_CONNECTION_STRING"

echo
echo "[4] BASELINE - CREATE AND UPLOAD BLOB"

echo "$CONTENT" > "$BLOB"

az storage blob upload \
  --container-name "$CONTAINER" \
  --name "$BLOB" \
  --file "$BLOB" \
  --connection-string "$AZURE_STORAGE_CONNECTION_STRING" \
  --overwrite

echo
echo "[5] BASELINE VERIFICATION"

az storage blob download \
  --container-name "$CONTAINER" \
  --name "$BLOB" \
  --file baseline.txt \
  --connection-string "$AZURE_STORAGE_CONNECTION_STRING"

echo "Baseline data:"
cat baseline.txt

echo
echo "BASELINE SUCCESS ✅"

echo
echo "============================================"
echo "CHAOS INJECTION - DELETE BLOB 💥"
echo "============================================"

az storage blob delete \
  --container-name "$CONTAINER" \
  --name "$BLOB" \
  --connection-string "$AZURE_STORAGE_CONNECTION_STRING"

echo "Blob deleted."

echo
echo "[6] IMPACT OBSERVATION"

if az storage blob download \
  --container-name "$CONTAINER" \
  --name "$BLOB" \
  --file after-chaos.txt \
  --connection-string "$AZURE_STORAGE_CONNECTION_STRING"; then

    echo "UNEXPECTED: Blob is still accessible"

else

    echo "EXPECTED FAILURE CONFIRMED ❌"
    echo "Impact: Application cannot retrieve required configuration."
fi

echo
echo "============================================"
echo "RECOVERY 🔄"
echo "============================================"

echo "$CONTENT" > "$BLOB"

az storage blob upload \
  --container-name "$CONTAINER" \
  --name "$BLOB" \
  --file "$BLOB" \
  --connection-string "$AZURE_STORAGE_CONNECTION_STRING" \
  --overwrite

az storage blob download \
  --container-name "$CONTAINER" \
  --name "$BLOB" \
  --file recovered.txt \
  --connection-string "$AZURE_STORAGE_CONNECTION_STRING"

echo
echo "Recovered data:"
cat recovered.txt

echo
echo "RECOVERY SUCCESSFUL ✅"

echo
echo "============================================"
echo "AZURE CHAOS #1 COMPLETED"
echo "============================================"

