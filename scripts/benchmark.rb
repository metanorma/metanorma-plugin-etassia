# frozen_string_literal: true

# Benchmarks the plugin's rendering path on the PlantUML corpus: the
# Ruby pipeline (ETASSIA_RUNTIME=ruby) against the native engine, when
# the etassia-native gem is installed outside this bundle.
#
#   ruby scripts/benchmark.rb [rounds]
#
# This script deliberately runs OUTSIDE the bundle (plain `ruby`, no
# bundle exec): the etassia gem comes from the load path, and
# etassia-native joins it when present. Under `bundle exec` the native
# gem cannot load and the native leg reports unavailable.
require "etassia"

rounds = (ARGV[0] || 20).to_i
fixtures = Dir.glob("#{__dir__}/../spec/fixtures/corpus/*.puml").sort
if fixtures.empty?
  warn "no corpus fixtures found"
  exit 1
end

# Both legs must render the same work: keep only the sources the
# engine accepts, and say what dropped out.
sources = []
skipped = []
fixtures.each do |path|
  name = File.basename(path)
  begin
    Etassia.render(File.read(path))
    sources << [name, File.read(path)]
  rescue StandardError, ScriptError => e
    skipped << "#{name} (#{e.class})"
  end
end
warn "benchmarked #{sources.size} fixtures; skipped #{skipped.size}:"
skipped.each { |line| warn "  #{line}" }
exit 1 if sources.empty?

def time(renders, rounds)
  t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  renders.each { |source| yield source }
  t = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
  per_diagram = t / (renders.size * rounds) * 1000
  warn format("  %d rounds x %d fixtures: %.2fs (%.1f ms/diagram)",
              rounds, renders.size, t, per_diagram)
  t
end

ENV["ETASSIA_RUNTIME"] = "ruby"
warn "ruby pipeline:"
ruby_total = time(sources.map(&:last), rounds) { |source| Etassia.render(source) }

Etassia::Runtime.reset!
ENV.delete("ETASSIA_RUNTIME")
unless Etassia::Runtime.native?
  warn "native engine: etassia-native is not on the load path; skipping"
  warn "ratio so far: ruby only"
  exit 0
end

warn "native engine:"
native_total = time(sources.map(&:last), rounds) { |source| Etassia.render(source) }
warn format("speedup: %.1fx", ruby_total / native_total)
