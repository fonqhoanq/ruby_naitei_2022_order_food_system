module Admin::OrdersHelper
  def check_status order
    if order.inactive?
      content_tag(:span, I18n.t("admin.orders.order.inactive"), class: ["badge", "badge-secondary"])
    elsif order.actived? 
      content_tag(:span, I18n.t("admin.orders.order.actived"), class: ["badge", "badge-success"])
    else  
      content_tag(:span, I18n.t("admin.orders.order.paid"), class: ["badge", "badge-paid"])
    end
  end

  def order_status_options
    Order.statuses.map do |status|
      status
    end.unshift(["all", ""])
  end
end
