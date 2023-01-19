module Exporters
  class Factory
    def self.call(format)
      case format
      when 'csv'
        Exporters::CsvExporter.call
      when 'pdf'
        Exporters::PdfExporter.call
      when 'html'
        Exporters::HtmlExporter.call
      when 'markdown'
        Exporters::MarkdownExporter.call
      when 'wookie'
        Exporters::WookieExporter.call
      end
    end
  end
end
