#!/usr/bin/env bash
set -euo pipefail

mkdir -p "${OUT_DIR}"
mkdir -p "${CACHE_DIR}"

# Copy the melange config to the output dir so it will be saved with the
# rest of the build artifacts.
cp "${MELANGE_CONFIG_FILE}" "${OUT_DIR}/melange.yaml"

# Get a temporary file to store the private signing key
SIGNING_KEY_FILE=$(mktemp --tmpdir="${RUNNER_TEMP}" --suffix=.rsa)

# Make sure we delete the private signing key file at the end of this step
trap 'rm -f "${SIGNING_KEY_FILE}"' EXIT

# Put the private signing key into a file
chmod 600 "${SIGNING_KEY_FILE}"
echo -n "${SIGNING_KEY}" > "${SIGNING_KEY_FILE}"

# Store the public signing key in the output dir so it will be saved with
# the rest of the build artifacts.
openssl rsa -in "${SIGNING_KEY_FILE}" -pubout -out "${OUT_DIR}/signing.rsa.pub"

# Do the actual build
melange \
  build \
  --cache-dir="${CACHE_DIR}" \
  --out-dir="${OUT_DIR}" \
  --arch="${ARCH}" \
  --signing-key="${SIGNING_KEY_FILE}" \
  "${MELANGE_CONFIG_FILE}"
