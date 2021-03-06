#!/bin/bash
set -euo pipefail

echo "Uploading stage 1 (full)"

{% for distro in distros.keys() -%}
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-$1-{{ distro }}; then echo -e "UPLOAD build1-$1-{{ distro }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build1-$1-{{ distro }}" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
