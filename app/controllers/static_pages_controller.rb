class StaticPagesController < ApplicationController
  def home
    @products = Product.filter_by_starts_with(params[:starts_with]).newest
    @pagy, @products = pagy @products, items: Settings.pagy.item_9
  end

  def help; end
end
