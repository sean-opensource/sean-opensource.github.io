# Chilepluto Site Update Review

## Completed Baseline Fixes

- Repaired `CNAME` so it contains only `chilepluto.com`.
- Updated canonical site metadata to use `https://chilepluto.com`.
- Removed placeholder social links and blanked the unused Twitter account.
- Updated the deploy workflow to `actions/checkout@v6` and Ruby 3.4.
- Added `tools/local.sh` for local setup, production checks, and live preview.
- Updated Liquid from 4.0.3 to 4.0.4 so the older theme renders on Ruby 3.2.
- Corrected PowerShell taxonomy and generalized the public ADFS examples.
- Corrected typoed Python post slugs while preserving old URLs with redirects.
- Removed duplicate headings and generated-text artifacts from posts.

## Completed Chirpy 7.5 Migration

- Upgraded `jekyll-theme-chirpy` from 5.2.0 to 7.5.0.
- Replaced the force-push `gh-pages` workflow with GitHub Pages artifacts.
- Updated CI and local builds to Ruby 3.4 and `html-proofer` 5.x.
- Opted GitHub Actions into Node.js 24 ahead of the runner default change on
  June 16, 2026.
- Removed copied v5 locale and asset overrides so the theme gem provides the
  current versions.
- Updated the static-assets submodule to the commit pinned by Chirpy Starter
  7.5.0.
- Added `jekyll-redirect-from` explicitly so published legacy URLs remain valid
  after the v7 migration.
- Added descriptions and specific tags to each article.
- Refreshed the WSL, GPT-2, regression, PowerShell, and ADFS guidance.

## Recommended Next Update

1. Add a real avatar and custom favicon set. The current sidebar has no avatar
   and still relies on starter assets.
2. Add source links and tested-version notes to technical tutorials.
3. Add a content-review date to each article and revisit tutorials after major
   tool releases.

## Article Review

### Map a Network Drive with New-PSDrive

- Add a note on removing a mapped drive with `Remove-PSDrive`.

### WSL Setup

- Keep the current Windows 10 version 2004 or Windows 11 prerequisite.
- Add a note for `wsl --install --web-download -d <DistroName>` when Store
  installation is unavailable or stalls.

### Local GPT-2 with Python

- Add CPU, Apple Silicon, and GPU notes so hardware expectations are realistic.

### Linear Regression

- Add a residual plot and a train-versus-test comparison.

### ADFS Claim Rules

- Add a complete `try`/`catch` wrapper around the import path.

## Reference Links

- [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Basic commands for WSL](https://learn.microsoft.com/en-us/windows/wsl/basic-commands)
- [Hugging Face GPT-2 documentation](https://huggingface.co/docs/transformers/model_doc/gpt2)
- [Chirpy releases](https://github.com/cotes2020/jekyll-theme-chirpy/releases)
- [Chirpy upgrade guide](https://github.com/cotes2020/jekyll-theme-chirpy/wiki/Upgrade-Guide)
