.PHONY: *

default: test

build:
	rm *.gem
	gem build dec.gemspec

publish: build
	gem push *.gem

test:
	ruby -Ilib:spec spec/*_spec.rb

bench:
	ruby -Ilib:spec bench/*_bench.rb
