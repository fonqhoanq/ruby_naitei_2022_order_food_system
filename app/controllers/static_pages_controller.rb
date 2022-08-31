class StaticPagesController < ApplicationController
  def home
    @searchs = Product.ransack(params[:q])
    @pagy, @products = pagy @searchs.result.newest, items: Settings.pagy.item_9
  end

  def help; end
end
