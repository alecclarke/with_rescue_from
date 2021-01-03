require_relative 'lib/with_rescue_from/version'

Gem::Specification.new do |spec|
  spec.name          = "with_rescue_from"
  spec.version       = WithRescueFrom::VERSION
  spec.authors       = ["Alec Clarke"]
  spec.summary       = %q{Rescue exceptions raised from given methods with ActiveSupport::Rescuable rescue_from.}
  spec.description   = <<~EOF
    WithRescueFrom conveniently provides rescue_from handling for
    given methods by wrapping each method with ActiveSupport::Rescuable's
    rescue_with_handler exception handling.
  EOF
  spec.homepage      = "https://github.com/alecclarke/with_rescue_from"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alecclarke/with_rescue_from"
  spec.metadata["changelog_uri"] = "https://github.com/alecclarke/with_rescue_from"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 5.0"
  spec.add_dependency "ruby2_keywords", "~> 0"

  spec.add_development_dependency "rspec", "~> 3.5"
end
