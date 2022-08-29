class OrdersController < ApplicationController
  before_action :get_order, only: :show
  def index
    @pagy, @orders = pagy(current_user.orders.newest,
                          items: Settings.pagy.item_5)
  end

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
      flash[:success] = t ".create_order_success"
      redirect_to @order
    else
      flash[:danger] = t(".create_order_fail")
      render :new
    end
  end

  def show; end

  private

  def order_params
    params.require(:order)
          .permit(:user_id, :user_name, :address, :phone_number,
                  :note, :payment_type, :total)
  end

  def total_price_from_cart
    session[:cart]["tottal_price"]
  end

  def get_order
    @order = Order.find_by_id(params[:id])
    return if @order

    flash[:danger] = t(".order_not_found")
    redirect_to root_path
  end
end
