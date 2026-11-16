require_relative "lib/metanorma/plugin/etassia/version"

Gem::Specification.new do |spec|
  spec.name = "metanorma-plugin-etassia"
  spec.version = Metanorma::Plugin::Etassia::VERSION
  spec.authors = ["Ribose Inc."]
  spec.email = ["open.source@ribose.com"]

  spec.summary = "Metanorma plugin: diagram blocks rendered through Etassia"
  spec.description = "Metanorma AsciiDoc extension that renders diagram " \
    "blocks (PlantUML, Mermaid) through Etassia, the pure-Ruby diagram " \
    "interpreter — no Java, no external renderer."
  spec.homepage = "https://github.com/metanorma/metanorma-plugin-etassia"
  spec.license = "BSD-2-Clause"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.required_ruby_version = Gem::Requirement.new(">= 3.1.0")

  spec.files = `git ls-files`.split("\n")
    .reject { |f| f.match(%r{\A(?:(?:test|spec|features)/|\.)}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "asciidoctor", "~> 2.0"
  spec.add_dependency "etassia", ">= 0.1.0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rexml"
  spec.add_development_dependency "rspec"
end
