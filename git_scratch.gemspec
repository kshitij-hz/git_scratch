
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

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
