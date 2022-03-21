#!/usr/bin/env bash
set -Eeuo pipefail

chown -R ${uid}:${uid} ${workdir}

# set reduced priviledges
exec setpriv --reuid=${uid} --regid=${uid} --init-groups $@
