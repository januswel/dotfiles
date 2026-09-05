#!/bin/sh

set -eux

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
echo "${SCRIPT_DIR}"

ROOT=$(cd "$(dirname "$0")/.."; pwd)
echo "${ROOT}"

COMMAND_NAME=$(basename "$0")
echo "${COMMAND_NAME}"
