#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${SIGNING_KEY:-}" && -z "${SIGNING_KEY_NAME:-}" ]]; then
  echo "::error::You provided 'signing-key' but did not provide 'signing-key-name'" >&2
  exit 1
fi

if [[ -n "${SIGNING_KEY_NAME:-}" && -z "${SIGNING_KEY:-}" ]]; then
  echo "::error::You provided 'signing-key-name' but did not provide 'signing-key'" >&2
  exit 1
fi

echo "Prepare output directories..."
mkdir -p "${OUT_DIR}"
mkdir -p "${CACHE_DIR}"

NAMESPACE_ARGS=()
if [[ -n "${PACKAGE_NAMESPACE:-}" ]]; then
  NAMESPACE_ARGS=("--namespace=${PACKAGE_NAMESPACE}")
fi

SIGNING_ARGS=()
if [[ -n "${SIGNING_KEY:-}" ]]; then
  echo "::group::Prepare for signing"

  echo "Prepare private key..."

  # Get a temporary dir to store the private signing key
  SIGNING_KEY_DIR=$(mktemp -d --tmpdir="${RUNNER_TEMP}")

  # Make sure we delete the private signing key file at the end of this step
  trap 'rm -rf "${SIGNING_KEY_DIR}"' EXIT

  # Put the private signing key into a file
  SIGNING_KEY_FILE="${SIGNING_KEY_DIR}/${SIGNING_KEY_NAME}.rsa"
  touch "${SIGNING_KEY_FILE}"
  chmod 600 "${SIGNING_KEY_FILE}"
  printf '%s' "${SIGNING_KEY}" > "${SIGNING_KEY_FILE}"

  SIGNING_ARGS=("--signing-key=${SIGNING_KEY_FILE}")

  echo "::endgroup::"
fi

echo "::group::Build packages"

# Do the actual build
melange \
  build \
  --cache-dir="${CACHE_DIR}" \
  --out-dir="${OUT_DIR}" \
  --arch="${ARCH}" \
  "${NAMESPACE_ARGS[@]}" \
  "${SIGNING_ARGS[@]}" \
  --generate-index="${GENERATE_INDEX}" \
  --generate-provenance="${GENERATE_PROVENANCE}" \
  "${MELANGE_CONFIG_FILE}"

echo "::endgroup::"
