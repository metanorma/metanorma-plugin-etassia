source "https://rubygems.org"

gemspec

# Until etassia releases its PlantUML families. Pinned to a
# revision (not the moving branch) so CI is deterministic; the not-applicable
# table in spec/plantuml_corpus_spec.rb matches this revision. Bump both together.
gem "etassia", git: "https://github.com/etassia/etassia",
              ref: "f7599cf1b2a29edd96aa536ecf65ac4b49b9ae22"

# The flavour smoke spec (spec/plantuml_flavor_standoc_spec.rb) converts through a
# real Metanorma flavour; it skips when the gem is absent.
gem "metanorma-standoc"
