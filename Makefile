.PHONY: serve build install new-post clean

# Run the dev server with live reload at http://localhost:4000
serve:
	bundle exec jekyll serve --livereload --future

# One-off build into _site/ (what GitHub Pages does on push)
build:
	bundle exec jekyll build

# Install Ruby gems (first time, or after Gemfile changes)
install:
	bundle install

# Create a new post folder for today. Title is optional:
#   make new-post                     -> _blog/YYYY-MM-DD/index.md, titled with the date
#   make new-post title="my post"     -> _blog/my-post/index.md
# Drop images in the same folder and reference them by filename.
new-post:
	@today=$$(date +%Y-%m-%d); \
	if [ -n "$$title" ]; then \
	  slug=$$(printf '%s' "$$title" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$$//g'); \
	  t=$$(printf '%s' "$$title" | sed 's/"/\\"/g'); \
	else \
	  slug=$$today; \
	  t=$$(date "+%B %-d, %Y"); \
	fi; \
	dir="_blog/$$slug"; \
	if [ -e "$$dir" ]; then echo "already exists: $$dir"; exit 1; fi; \
	mkdir -p "$$dir"; \
	printf -- '---\ntitle: "%s"\ndate: %s\ndescription: ""\nimage: ""\n---\n\n' "$$t" "$$today" > "$$dir/index.md"; \
	echo "created $$dir/index.md"

clean:
	rm -rf _site .jekyll-cache .jekyll-metadata
