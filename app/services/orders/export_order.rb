module Orders
  class ExportOrder
    prepend SimpleCommand

    def initialize(order_id, exporter)
      @order_id = order_id
      @exporter = exporter
    end

    def call
      # do sth with order before export
      @exporter.export
    end
  end

  private

  attr_reader :order_id, :exporter

end
