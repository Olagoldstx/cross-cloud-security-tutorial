#!/usr/bin/env bash
set -euo pipefail
if [[ $# -lt 1 ]]; then
  echo "Usage: ./scripts/render-one.sh diagrams/<file>.mmd"
  exit 2
fi

root="$(cd "$(dirname "$0")/.." && pwd)"
in_rel="$1"
in_abs="${root}/${in_rel}"
dir_abs="$(dirname "$in_abs")"
base="$(basename "$in_abs" .mmd)"
out_abs="${dir_abs}/${base}.png"

echo "Rendering ${in_rel} -> ${out_abs}"

if command -v docker >/dev/null 2>&1; then
  docker run --rm -u "$(id -u)":"$(id -g)" \
    -v "$dir_abs":/data ghcr.io/mermaid-js/mermaid-cli/mermaid-cli:latest \
    -i "/data/$(basename "$in_abs")" -o "/data/$(basename "$out_abs")"
else
  if command -v mmdc >/dev/null 2>&1; then
    MMDC="mmdc"
  else
    MMDC="npx -y @mermaid-js/mermaid-cli"
  fi
  cfg="${root}/diagrams/puppeteer-config.json"
  if [[ -f "$cfg" ]]; then
    $MMDC --input "$in_abs" --output "$out_abs" \
          --puppeteerConfigFile "$cfg" \
          --backgroundColor transparent --quiet --scale 1
  else
    $MMDC --input "$in_abs" --output "$out_abs" \
          --backgroundColor transparent --quiet --scale 1
  fi
fi

echo "✅ Wrote ${out_abs}"
