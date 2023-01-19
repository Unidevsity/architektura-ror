module Orders
  class ExportOrder
    prepend SimpleCommand

    def initialize(order_id, format)
      @order_id = order_id
      @format = format
    end

    def call
      case @format
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

  private

  attr_reader :order_id, :format, :export

end
