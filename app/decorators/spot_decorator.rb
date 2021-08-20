module SpotDecorator
  def restroom_qty_status
    restroom_qty.presence || 0
  end

  def wifi_status
    wifi ? '有' : '無'
  end
end
