class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_products, only: [:create]
  # POST /cart/:id/add-product
  def create
    get_products
    create_empty_cart if session[:cart].nil?
    fetch_add_product
    session[:cart]["tottal_count"] += 1
    session[:cart]["tottal_price"] += @product.price
    render json: {status: 200, message: t(".add_to_cart_success"),
                  "nav-cart-count": session[:cart]["tottal_count"]}
  end

  # POST /cart
  def show
    products = []
    create_empty_cart if session[:cart].nil?
    session[:cart]["products"].each do |product_id, value|
      if value
        product = Product.find(product_id.to_i)
        products << {product: product, count: value["count"]}
      end
    end
    render "index", locals: {
      products: products,
      tottal_price: session[:cart]["tottal_price"]
    }, layout: true
  end

  # POST cart/:id/plus-product
  def plus_product
    session[:cart]["products"][params[:id]]["count"] += 1
    session[:cart]["tottal_count"] += 1
    session[:cart]["tottal_price"] +=
      session[:cart]["products"][params[:id]]["price"]
    render json: {status: 200, message: t(".plus_product_success"),
                  "product-count": session[:cart]["products"][params[:id]]["count"],
                  "total-price-cart": session[:cart]["tottal_price"],
                  "nav-cart-count": session[:cart]["tottal_count"]}
  end

  # POST cart/:id/minus-product
  def minus_product
    session[:cart]["products"][params[:id]]["count"] -= 1
    session[:cart]["tottal_count"]           -= 1
    session[:cart]["tottal_price"]           -=
      session[:cart]["products"][params[:id]]["price"]
    zero_delete_product
    render json: {status: 200, message: t(".minus_product_success"),
                  "product-count": session[:cart]["products"][params[:id]]["count"],
                  "total-price-cart": session[:cart]["tottal_price"],
                  "nav-cart-count": session[:cart]["tottal_count"]}
  end

  private

  def create_empty_cart
    session[:cart] = {
      "products" => {},
      "tottal_count" => 0,
      "tottal_price" => 0
    }
  end

  def get_products
    @product = Product.find(params[:id])
    return if @product

    flash[:danger] = t(".product_not_found")
  end

  def zero_delete_product
    return unless (session[:cart]["products"][params[:id]]["count"]).zero?

    session[:cart]["products"].delete(params[:id])
  end

  def fetch_add_product
    if session[:cart]["products"][@product.id.to_s]
      session[:cart]["products"][@product.id.to_s]["count"] += 1
    else
      fetch_add_product_not_yet
    end
  end

  def fetch_add_product_not_yet
    session[:cart]["products"][@product.id.to_s] = {
      count: 1,
      price: @product.price,
      name: @product.name
    }
  end
end
