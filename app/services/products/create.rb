module Products
  class Create
    def initialize(params)
      @params = params
    end

    def call
      product_form = ProductForm.new(@params)
      if product_form.save
        product_form.product
      else
        product_form
      end
    end
  end
end
