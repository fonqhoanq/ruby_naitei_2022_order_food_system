module Admin::OrdersHelper
  def check_status order
    if order.inactive?
      return content_tag(:span,"Chưa phê duyệt",class: ["badge","badge-secondary"])
    elsif order.actived? 
      return content_tag(:span,"Đã phê duyệt",class: ["badge","badge-success"])
    else  
      return content_tag(:span,"Đã thanh toán",class: ["badge","badge-paid"])
    end
  end
end
