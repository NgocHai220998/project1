module SpotDecorator
  def restroom_qty_status
    return '0' if restroom_qty.nil?

    restroom_qty
  end

  def wifi_status
    return '無' if wifi.nil?

    '有'
  end
end
