# frozen_string_literal: true

require "asciidoctor"
require "digest"

require_relative "block_processor"
require_relative "plantuml_block_processor"
require_relative "plantuml_image_macro_processor"
require_relative "plantuml_override_preprocessor"

module Metanorma
  module Plugin
    module Etassia
      class Extensions
        # AsciiDoc extension registration: the `sirena` block and the
        # drop-in `[plantuml]` block and
        # `plantuml_image::` block macro.
        ::Asciidoctor::Extensions.register do
          block ::Metanorma::Plugin::Etassia::BlockProcessor
          block ::Metanorma::Plugin::Etassia::PlantumlBlockProcessor
          block_macro ::Metanorma::Plugin::Etassia::PlantumlImageMacroProcessor
          preprocessor ::Metanorma::Plugin::Etassia::PlantumlOverridePreprocessor
        end
      end
    end
  end
end
