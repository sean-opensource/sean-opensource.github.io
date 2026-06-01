#!/usr/bin/env bash

set -eu

# Keep the legacy Cloudflare Pages entrypoint while using the current build.
bash tools/local.sh build
JEKYLL_ENV=production bundle exec jekyll b -d _site
