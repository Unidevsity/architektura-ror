module PriceConversion
  def in_full_number(cents = price_cents)
    format('%.2f', cents.to_f / 100)
  end

  def in_currency(cents = price_cents, currency = 'USD')
    "#{in_full_number(cents)} #{currency}"
  end

  def price_in_full_number
    in_full_number(price_cents)
  end

  def price_in_currency(currency = 'USD')
    in_currency(price_cents, currency)
  end
end
