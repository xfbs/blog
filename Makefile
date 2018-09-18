SERVE_PORT   = 4001
SERVE_FLAGS += --livereload
SERVE_FLAGS += --incremental
SERVE_FLAGS += --drafts
SERVE_FLAGS += --unpublished
SERVE_FLAGS += --port $(SERVE_PORT)
BUILD_FLAGS +=
TMPDIR      = /var/tmp
PIDFILE     = $(TMPDIR)/jekyll.$(SERVE_PORT).pid
LOGFILE     = /dev/null

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
