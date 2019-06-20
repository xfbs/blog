SERVE_PORT   = 4000
SERVE_FLAGS += --drafts
SERVE_FLAGS += --port $(SERVE_PORT)
SERVE_FLAGS += --quiet
RELEASE_FLAGS += -d _release

ifeq ($(shell uname), Darwin)
  OPEN=open
else
  OPEN=xdg-open
endif

help:
	@echo "install  setup gems"
	@echo "serve    serve site"
	@echo "open     open site in browser"
	@echo "release  release site"

setup:
	bundle install

serve:
	bundle exec jekyll serve $(SERVE_FLAGS)

open:
	$(OPEN) "http://localhost:$(SERVE_PORT)"

release:
	bundle exec jekyll build $(RELEASE_FLAGS)
