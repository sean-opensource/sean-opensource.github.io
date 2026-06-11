# Chilepluto

Chilepluto is a personal technical site published at <https://chilepluto.com> using GitHub Pages and the Jekyll Chirpy theme.

The site is used for practical technical notes, guides, and reference material across PowerShell, Python, Windows, local AI workflows, automation, and related infrastructure topics.

## Repository

- Repository: `sean-opensource/sean-opensource.github.io`
- Default branch: `main`
- Published site: <https://chilepluto.com>
- GitHub Pages custom domain: `chilepluto.com`
- Site generator: Jekyll
- Theme: `jekyll-theme-chirpy`

## Site purpose

Chilepluto is intended to be a lightweight publishing platform for:

- Practical PowerShell notes and reusable scripts
- Python automation examples
- Windows administration notes
- Local AI workflow experiments
- Troubleshooting records and technical runbooks
- Short-form engineering references that are useful to revisit later

The content should favour clear, repeatable steps over theory-only posts.

## Technology stack

The site uses:

- GitHub Pages for hosting
- Jekyll for static site generation
- Chirpy for layout and blog features
- Ruby and Bundler for local builds
- Markdown for posts and pages

Core configuration is stored in `_config.yml`.

## Repository structure

Common paths:

```text
.
├── _config.yml        # Main Jekyll and site configuration
├── _posts/           # Published blog posts
├── _drafts/          # Draft posts, if used locally
├── _tabs/            # Top-level site tabs/pages
├── assets/           # Static assets such as images and CSS
├── index.html        # Home page entry point
├── CNAME             # GitHub Pages custom domain
├── Gemfile           # Ruby dependencies
└── README.md         # Project documentation
```

## Local development

This site uses Homebrew Ruby 3.4 on macOS.

Install Ruby if required:

```shell
brew install ruby@3.4
```

Prepare the local workspace:

```shell
bash tools/local.sh setup
```

Run the production-style build checks:

```shell
bash tools/local.sh build
```

Start a live local preview while editing:

```shell
bash tools/local.sh serve
```

The local preview is normally available at:

```text
http://127.0.0.1:4000
```

## Writing posts

Create posts under `_posts/` using the Jekyll naming convention:

```text
YYYY-MM-DD-post-title.md
```

Recommended front matter:

```yaml
---
title: "Post title"
date: YYYY-MM-DD HH:MM:SS +0930
categories: [Category]
tags: [tag-one, tag-two]
---
```

Writing guidance:

- Use descriptive titles that match the technical problem being solved.
- Keep commands in fenced code blocks.
- Include prerequisites and assumptions near the top of each post.
- Prefer repeatable steps and verification commands.
- Add screenshots or diagrams only when they materially improve the guide.
- Avoid publishing secrets, internal hostnames, credentials, keys, tokens, or private environment details.

## Deployment

Changes pushed to the `main` branch are published through GitHub Pages.

The custom domain is defined in `CNAME`:

```text
chilepluto.com
```

Before merging or pushing significant changes, run:

```shell
bash tools/local.sh build
```

## Maintenance checklist

Periodically review:

- `_config.yml` for site metadata, timezone, analytics, and social links
- `Gemfile` and `Gemfile.lock` for dependency updates
- GitHub Pages deployment status
- Broken links using the local build or HTML proofing checks
- Search engine verification and sitemap submission
- Old posts that may contain outdated commands or version-specific guidance

## Configuration notes

Important site settings are managed in `_config.yml`, including:

- Site title and tagline
- Canonical URL
- Timezone
- GitHub username
- Social links
- Analytics provider
- Comments provider
- PWA/cache settings
- Pagination and permalink behaviour

## Security and privacy

Do not commit:

- API keys or tokens
- Private SSH keys
- Internal-only documentation
- Sensitive screenshots
- Customer, government, or departmental information
- Private IP addressing or architecture details that should not be public

Use example values, redacted hostnames, and synthetic data where needed.

## Licence

Unless otherwise stated, repository content is published under the licence included in this repository.

Third-party theme, dependency, and tooling licences remain with their respective owners.
