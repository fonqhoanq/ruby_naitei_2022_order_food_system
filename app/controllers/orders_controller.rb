class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new order_params
    if @order.save
      session[:cart]["products"].each do |product_id, product|
        detail_order_params = {order_id: @order.id,
                              product_id: product_id.to_i,
                              quantity: product["count"],
                              price: product["price"]}
        DetailOrder.create(detail_order_params)
      end
      session.delete(:cart)
      redirect_to @order
    else
      flash[:danger] = t(".create_order_fail")
      render :new
    end
  end

  private

  def order_params
    params.require(:order)
          .permit(:user_id, :user_name, :address, :phone_number,
                  :note, :payment_type, total: total_price_from_cart)
  end

  def total_price_from_cart
    session[:cart]["tottal_price"]
  end
end
