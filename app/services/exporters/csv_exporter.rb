module Exporters
  class CsvExporter < BaseExporter
    def self.call
      @export = OpenStruct(name: 'CSV export')
    end
  end
end
