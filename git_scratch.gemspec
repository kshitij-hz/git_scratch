
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "git_scratch/version"

Gem::Specification.new do |spec|
  spec.name          = "git_scratch"
  spec.version       = GitScratch::VERSION
  spec.authors       = ["Kshitij Yadav"]
  spec.email         = ["kshitij.hz@gmail .com"]

  spec.summary       = %q{A gem for clearing old commits and refresh git as new initial commit.}
  spec.homepage      = "https://github.com/kshitij-hz/git_scratch"

  spec.add_dependency 'rails', '>= 3.0.0'
  spec.add_dependency 'thor', '>= 0.19.1'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = %w(lib)
end
