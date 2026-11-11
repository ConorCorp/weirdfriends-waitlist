# AGENTS.md: weirdfriends.app website

Marketing site and blog for weirdfriends (a language-learning app where you text
AI characters). Jekyll on GitHub Pages: pushing to `main` rebuilds the site.
`README.md` has the full layout of the repo; this file is the short version plus
how to write blog posts. `CLAUDE.md` is a symlink to this file.

The blog works the same way as the one in the sibling `skintheory-website` repo
(same folder layout, front matter, `make` targets, and the same `blog/feed.xml`).
Keep the two in step when changing how the blog works.

## Commands

```sh
make install                      # once: Ruby gems into vendor/
make serve                        # http://localhost:4000, live reload, shows future-dated posts
make build                        # build into _site/ as it will go live
make new title="post title"       # new post folder _blog/post-title/index.md (no title: folder named by date)
```

## Things not to break

- Every page uses `_layouts/default.html`; shared chrome is in `_includes/`
  (`head.html`, `nav.html`, `footer.html`, `store-buttons.html`, `scripts.html`).
- Colours are CSS variables in `_includes/base.css` with light and dark themes.
  Use the semantic tokens (`--bg`, `--surface`, `--ink`, `--line`, `--muted`,
  `--mint`, `--lavender`, ...) so both themes work.
- Language pages: content lives in `_data/languages.yml`, one front-matter file per
  language in `_languages/` (see README).
- The site's voice is lowercase and playful (headings, nav, buttons). Match it.
- Commit or push only when asked.

## Writing a blog post

1. **Create it**: `make new title="..."` or `make new` (folder named by today's
   date, which is what most existing posts use). The folder name becomes the URL
   (`_blog/<folder>/` is served at `/blog/<folder>/`).
2. **Front matter**:
   ```yaml
   ---
   title: "app update v1.8.0"
   date: 2026-10-04              # required; sets the order
   author: Conor
   description: "One sentence for the blog card, search results and share previews."
   image: cover.png              # optional featured image, in the post's folder
   image_alt: "What the image shows"
   ---
   ```
   For a draft, add `published: false`. A future `date` hides the post from the
   blog page and feed, but GitHub Pages only rebuilds on push, so it goes live on
   the first push after that date.
3. **Text**: posts are often copies of Conor's mailing-list emails. Keep his
   wording and voice: fix typos and grammar only, use `##` headings for the
   email's sections, and bold a few key phrases at most. Don't rewrite, add
   marketing copy, or invent details. Mention any edit beyond typo fixes.
4. **Images** go in the post's folder, referenced by filename (`![alt](name.webp)`).
   Convert them to WebP and give them a width and height so the page doesn't jump:
   - Phone screenshots: `cwebp -q 82 -resize 640 0 in.png -o name.webp`, then
     `![What the screen shows](name.webp){: .screenshot width="640" height="H"}`
     (H = original height x 640 / original width). `.screenshot` shows them at
     phone size, centred.
   - Squarish images such as charts: `{: .narrow width="W" height="H"}` (max 520px wide).
   - Wide images, photos and GIFs fill the column. Export about 1600px wide.
   - Always write real alt text describing what the image shows.
5. **Featured image**: `image:` is shown at the top of the post, on its card on
   `/blog/` and as the share preview. A landscape image works best; without one
   the site's `assets/og.png` is used for sharing.
6. **Check it**: `make serve`, then look at `/blog/` and the post at phone and
   desktop widths (360px and 1440px at least), in light and dark mode. Nothing
   should scroll sideways. `/blog/feed.xml` should list the post with absolute
   image URLs.

## Where things are

| Path | What |
| --- | --- |
| `_blog/<slug>/index.md` | Posts, with their images beside them |
| `blog/index.html` | `/blog/`: list of posts |
| `blog/feed.xml` | Atom feed (hand-written; skips future posts, makes image URLs absolute) |
| `_layouts/post.html` | Single post, including its styles (`.post-body`, `.screenshot`, `.narrow`) |
| `_layouts/default.html`, `_includes/` | Page shell and shared parts |
