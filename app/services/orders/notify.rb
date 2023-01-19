module Orders
  class Notify
    def initialize(order_id, notify_by)
      @order_id = order_id
      @notify_by = notify_by || []
    end

    def call
      if notify_by.include?('email')
        notify_by_email
      elsif notify_by.include?('sms')
        notify_by_sms
      end
    end

    private

    attr_reader :order_id, :notify_by

    def notify_by_email
      # send email notifications
    end

    def notify_by_sms
      # send sms notifications
    end
  end
end
