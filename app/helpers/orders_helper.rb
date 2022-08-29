module OrdersHelper
  def get_products_cart
    products = []
    if session[:cart].present?
      session[:cart]["products"].each do |product_id, product|
        if product
          product_info = Product.find(product_id.to_i)
          products << {product: product_info, count: product["count"]}
        end
      end
    end
    products
  end

  def get_total_price
    session[:cart]["tottal_price"]
  end

  def check_status order
    if order.inactive?
      return content_tag(:span, t("orders.index.inactive"),
                         class: %w(badge badge-secondary))
    elsif order.actived? 
      return content_tag(:span, t("orders.index.actived"),
                         class: %w(badge badge-success))
    else  
      return content_tag(:span, t("orders.index.paid"), class: %w(badge badge-paid))
    end
  end
end
