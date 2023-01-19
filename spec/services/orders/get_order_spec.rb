# frozen_string_literal: true

describe Orders::GetOrder do
  let(:order) { create(:order) }

  subject { described_class.new(order.id).call }

  it 'returns an order' do
    expect(subject).to eq(order)
  end
end
