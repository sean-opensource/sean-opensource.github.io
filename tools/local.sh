#!/usr/bin/env bash

set -eu

RUBY_PREFIX="/opt/homebrew/opt/ruby@3.4"
RUBY_GEMS="/opt/homebrew/lib/ruby/gems/3.4.0/bin"

if [[ ! -x "$RUBY_PREFIX/bin/ruby" ]]; then
  echo "Homebrew Ruby 3.4 is required. Install it with: brew install ruby@3.4" >&2
  exit 1
fi

export PATH="$RUBY_PREFIX/bin:$RUBY_GEMS:$PATH"

case "${1:-serve}" in
  setup)
    git submodule update --init --recursive
    bundle config set --local path vendor/bundle
    bundle install
    ;;
  build)
    bash tools/test.sh
    ;;
  serve)
    bundle exec jekyll serve --livereload --livereload-port 35730
    ;;
  *)
    echo "Usage: bash tools/local.sh [setup|build|serve]" >&2
    exit 1
    ;;
esac
