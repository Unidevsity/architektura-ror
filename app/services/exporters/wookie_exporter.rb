module Exporters
  class WookieExporter < BaseExporter
    def self.export
      @export = OpenStruct(name: 'Wookie export')
    end
  end
end
