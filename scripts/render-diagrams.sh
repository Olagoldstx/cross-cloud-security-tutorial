#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../diagrams"

shopt -s nullglob
files=( *.mmd )
if (( ${#files[@]} == 0 )); then
  echo "No .mmd files found; creating a smoke test..."
  cat > _smoke.mmd <<'EOF'
flowchart TD
  A[It works] --> B[Great!]
EOF
  files=( _smoke.mmd )
fi

use_docker=false
if command -v docker >/dev/null 2>&1; then
  use_docker=true
fi

for f in "${files[@]}"; do
  base="${f%.mmd}"
  out="${base}.png"               # <— guaranteed proper extension
  echo "Rendering ${f} -> ${out}"

  if $use_docker; then
    # Run as current user so files are writable outside the container
    docker run --rm -u "$(id -u)":"$(id -g)" \
      -v "$PWD":/data ghcr.io/mermaid-js/mermaid-cli/mermaid-cli:latest \
      -i "/data/${f}" -o "/data/${out}"
  else
    if command -v mmdc >/dev/null 2>&1; then
      MMDC="mmdc"
    else
      MMDC="npx -y @mermaid-js/mermaid-cli"
    fi
    # Use a local puppeteer config if present
    CFG="puppeteer-config.json"
    if [[ -f "$CFG" ]]; then
      $MMDC --input "$f" --output "$out" \
            --puppeteerConfigFile "$CFG" \
            --backgroundColor transparent --quiet --scale 1
    else
      $MMDC --input "$f" --output "$out" \
            --backgroundColor transparent --quiet --scale 1
    fi
  fi
done

echo "✅ All diagrams rendered:"
ls -lh *.png
