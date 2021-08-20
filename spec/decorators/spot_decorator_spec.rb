# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpotDecorator do
  describe 'restroom_qty_status' do
    it 'restroom_qtyがnil場合' do
      spot = Spot.new
      decorated_spot = ActiveDecorator::Decorator.instance.decorate(spot)

      expect(decorated_spot.restroom_qty_status).to eq('0')
    end

    it 'restroom_qtyがnilじゃ無い場合' do
      spot = Spot.new(restroom_qty: "5")
      decorated_spot = ActiveDecorator::Decorator.instance.decorate(spot)

      expect(decorated_spot.restroom_qty_status).to eq('5')
    end
  end

  describe 'wifi_status' do
    it 'wifiがnil場合' do
      spot = Spot.new
      decorated_spot = ActiveDecorator::Decorator.instance.decorate(spot)

      expect(decorated_spot.wifi_status).to eq('無')
    end

    it 'restroom_qtyがnilじゃ無い場合' do
      spot = Spot.new(wifi: '有')
      decorated_spot = ActiveDecorator::Decorator.instance.decorate(spot)

      expect(decorated_spot.wifi_status).to eq('有')
    end
  end
end
