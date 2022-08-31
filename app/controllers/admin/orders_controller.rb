class Admin::OrdersController < Admin::BaseController
  before_action :find_order_by_id, except: %i(index)

  def index
    @searchs = Order.ransack(params[:q])
    @pagy, @orders = pagy @searchs.result.newest, items: Settings.pagy.item_5
  end

  def edit; end

  def update
    if @order.actived!
      flash[:success] = t ".approve_success"
      redirect_to admin_orders_path
    else
      flash[:error] = t ".approve_failed"
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:error] = t ".delete_failed"
    end
    redirect_to admin_orders_path
  end

  private
  def find_order_by_id
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:error] = t ".not_found"
    redirect_to admin_orders_path
  end
end
