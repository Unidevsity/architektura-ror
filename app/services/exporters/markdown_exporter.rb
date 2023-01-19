module Exporters
  class MarkdownExporter < BaseExporter
    def self.export
      @export = OpenStruct(name: 'Markdown export')
    end
  end
end
