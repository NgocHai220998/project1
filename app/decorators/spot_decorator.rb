module SpotDecorator
  def restroom_qty_status
    if restroom_qty.nil?
      "\x1D0"
    else
      restroom_qty
    end
  end

  def wifi_status
    if wifi.nil?
      '無'
    else
      '有'
    end
  end
end
