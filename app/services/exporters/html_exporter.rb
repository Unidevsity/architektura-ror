module Exporters
  class HtmlExporter < BaseExporter
    def self.export
      @export = OpenStruct(name: 'HTML export')
    end
  end
end
