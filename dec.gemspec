# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name              = "dec"
  s.version           = "0.0.1"
  s.summary           = "method decorator"
  s.authors           = ["elcuervo"]
  s.licenses          = %w[MIT]
  s.email             = ["elcuervo@elcuervo.net"]
  s.homepage          = "http://github.com/elcuervo/dec"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files test`.split("\n")

  s.add_development_dependency("benchmark-ips", "~> 2.8.4")
end
