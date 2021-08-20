# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpotDecorator do
  subject do
    ActiveDecorator::Decorator.instance.decorate(spot1)
  end

  describe 'restroom_qtyとwifiがnil' do
    let(:spot1) do
      Spot.new
    end

    it '正しい結果' do
      expect(subject.restroom_qty_status).to eq(0)
      expect(subject.wifi_status).to eq('無')
    end
  end

  describe 'restroom_qtyとwifiがnilじゃない' do
    let(:spot1) do
      Spot.new(restroom_qty: 5, wifi: '有')
    end

    it '正しい結果' do
      expect(subject.restroom_qty_status).to eq('5')
      expect(subject.wifi_status).to eq('有')
    end
  end
end
