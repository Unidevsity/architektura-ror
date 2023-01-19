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
        export_order_to_csv
      when 'pdf'
        export_order_to_pdf
      when 'html'
        export_order_to_html
      end
    end
  end

  private

  attr_reader :order_id, :format, :export

  def export_order_to_csv
    @export = OpenStruct(name: 'CSV export')
  end

  def export_order_to_pdf
    @export = OpenStruct(name: 'PDF export')
  end

  def export_order_to_html
    @export = OpenStruct(name: 'HTML export')
  end


end
