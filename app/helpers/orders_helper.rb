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
end
