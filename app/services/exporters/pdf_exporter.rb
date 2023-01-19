module Exporters
  class PdfExporter < BaseExporter
    def self.export
      @export = OpenStruct(name: 'PDF export')
    end
  end
end
