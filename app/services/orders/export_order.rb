module Orders
  class ExportOrder

    def initialize(order_id, format, notify_by)
      @order_id = order_id
      @format = format
      @notify_by = notify_by || []
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

      if notify_by.include?('email')
        notify_by_email
      elsif notify_by.include?('sms')
        notify_by_sms
      end
    end

  end

  private

  attr_reader :order_id, :format, :export, :notify_by

  def export_order_to_csv
    @export = OpenStruct(name: 'CSV export')
  end

  def export_order_to_pdf
    @export = OpenStruct(name: 'PDF export')
  end

  def export_order_to_html
    @export = OpenStruct(name: 'HTML export')
  end

  def notify_by_email
    # send email notifications
  end

  def notify_by_sms
    # send sms notifications
  end
end
