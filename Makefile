SHELL := /usr/bin/env bash
.PHONY: help diagrams install-diagram-deps clean-diagrams render-one

help:
	@echo "Targets:"
	@echo "  make install-diagram-deps  - Install libs + Mermaid CLI (npm)"
	@echo "  make diagrams              - Render all Mermaid .mmd to .png"
	@echo "  make clean-diagrams        - Delete generated PNGs"
	@echo "  make render-one FILE=...   - Render a single .mmd file"

install-diagram-deps:
	sudo apt-get update -y
	sudo apt-get install -y npm nodejs \
	  ca-certificates fonts-noto fonts-noto-color-emoji \
	  libasound2 libatk1.0-0 libatk-bridge2.0-0 libcairo2 libgtk-3-0 libgbm1 \
	  libnss3 libx11-xcb1 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxrandr2 libxss1 \
	  libpango-1.0-0
	sudo npm install -g @mermaid-js/mermaid-cli
	@echo "✅ Deps installed."

diagrams:
	@./scripts/render-diagrams.sh

clean-diagrams:
	@find diagrams -maxdepth 1 -type f -name '*.png' -print -delete
	@echo "🧹 Removed PNGs."

render-one:
	@if [ -z "$(FILE)" ]; then echo "Usage: make render-one FILE=diagrams/foo.mmd"; exit 2; fi
	@./scripts/render-one.sh "$(FILE)"
