class Admin::OrdersController < Admin::BaseController
  def index
    @pagy, @orders = pagy Order.all.newest, items: Settings.pagy.item_5
  end

  def destroy; end

  def approve; end
end
