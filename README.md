# weirdfriends.app

Static site for [weirdfriends.app](https://weirdfriends.app), deployed by GitHub Pages straight from `main`.

Most pages are plain HTML files. The blog at `/blog/` is built by Jekyll, which GitHub Pages runs automatically on every push. No build step to run before committing.

## Adding a blog post

```sh
make new-post                      # titled with today's date
make new-post title="my post title"
```

Each post is a folder in `_blog/` holding an `index.md` and any images for that post:

```
_blog/
  my-post-title/
    index.md
    cover.gif
    screenshot.png
```

Without a title the folder is named with today's date, e.g. `_blog/2026-09-08/`, and the post is titled "September 8, 2026". The folder name is the URL, so `_blog/my-post-title/` is served at `/blog/my-post-title/`. Rename the folder to change the URL.

The front matter looks like:

```markdown
---
title: my post title
date: 2026-09-08
description: one-line summary shown on the blog index (optional)
image: cover.gif               # featured image (optional)
---

your post here. headings, lists, links, images, code blocks all work.
```

`date` is required and sets the publish date and ordering. Posts dated in the future are not published until that date passes.

### Images

Put them in the post's folder and reference them by filename.

- **Featured image**, shown at the top of the post, as a thumbnail on the blog index, and as the preview image when the post is shared: `image: cover.gif`. Add `image_alt: describe the image` for alt text (defaults to the post title). Leave `image` empty or remove it for none.
- **Inline images** anywhere in the post: `![alt text](screenshot.png)`.

Gifs work the same as any image. An image shared between posts can live anywhere else in the repo and be referenced with an absolute path like `/blog/shared.png`.

Commit and push. The post shows up on `/blog/` and at its own URL within a minute or two.

## Previewing locally

One-time setup (Ruby 3.3 via rbenv, then the same gems GitHub Pages uses):

```sh
rbenv install -s 3.3.9   # .ruby-version pins the repo to this
make install
```

Then:

```sh
make serve
```

Open <http://localhost:4000>. The home page, `/blog/`, and every post are served exactly as they'll appear on GitHub Pages, plus future-dated posts so you can preview them. Edits to markdown files and layouts rebuild and refresh the browser automatically. Changes to `_config.yml` need a restart.

Other targets: `make build` writes the site to `_site/`, `make clean` removes build output.

## Where things live

- `_blog/` — blog posts, one folder each with `index.md` and its images
- `_layouts/post.html` — the HTML wrapper every post is rendered into
- `blog/index.html` — the post list
- `_config.yml` — Jekyll settings, including the `_blog` collection and its `/blog/<slug>/` URLs
- `Makefile` — `serve`, `new-post`, `build`, `install`, `clean`
- `Gemfile` — pins the `github-pages` gem so local builds match production
- `_site/` — generated output, ignored by git
