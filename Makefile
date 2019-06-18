SERVE_PORT   = 4001
SERVE_FLAGS += --livereload
#SERVE_FLAGS += --incremental
SERVE_FLAGS += --drafts
SERVE_FLAGS += --unpublished
SERVE_FLAGS += --port $(SERVE_PORT)
BUILD_FLAGS +=
RELEASE_FLAGS += -d _release
TMPDIR      = /var/tmp
PIDFILE     = $(TMPDIR)/jekyll.$(SERVE_PORT).pid
LOGFILE     = /dev/null

help:
	@echo "install  setup gems"
	@echo "serve    serve site in background"
	@echo "stop     stop serving in background"
	@echo "status   check if currently serving"
	@echo "open     open site in browser"
	@echo "build    build site"
	@echo "release  release site"

setup:
	bundle install

serve:
	bundle exec jekyll serve $(SERVE_FLAGS) >> $(LOGFILE) & echo $$! > $(PIDFILE) && disown

stop: $(PIDFILE)
	kill "$$(< $(PIDFILE))"
	rm $(PIDFILE)

status:
	@if test -f $(PIDFILE) && kill -0 "$$(< $(PIDFILE))" 2> /dev/null; then echo "running"; else echo "stopped"; fi

open:
	open "http://localhost:$(SERVE_PORT)"

build:
	bundle exec jekyll build $(BUILD_FLAGS)

release:
	bundle exec jekyll build $(RELEASE_FLAGS)
