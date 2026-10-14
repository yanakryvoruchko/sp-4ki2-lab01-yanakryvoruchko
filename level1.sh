#!/usr/bin/env bash
set -euo pipefail

docker rm -f vtfk-lab01 >/dev/null 2>&1 || true

docker run -d \
  --name vtfk-lab01 \
  ubuntu:24.04 \
  sleep infinity >/dev/null

docker exec -e VTFK_NONCE=13 vtfk-lab01 \
  sh -c 'printf "%s" "$VTFK_NONCE" > /tmp/vtfk-nonce'

CONTAINER_PID=$(docker exec vtfk-lab01 sh -c 'cat /proc/1/stat | cut -d" " -f1')
CONTAINER_PROCS=$(docker exec vtfk-lab01 sh -c 'ls -d /proc/[0-9]* 2>/dev/null | wc -l')
HOST_PROCS=$(ls -d /proc/[0-9]* 2>/dev/null | wc -l)

echo "CONTAINER_PID=$CONTAINER_PID"
echo "CONTAINER_PROCS=$CONTAINER_PROCS"
echo "HOST_PROCS=$HOST_PROCS"