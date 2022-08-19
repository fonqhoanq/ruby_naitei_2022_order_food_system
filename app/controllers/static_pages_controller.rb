class StaticPagesController < ApplicationController
  def home
    @pagy, @products = pagy Product.all.newest, items: Settings.pagy.item_9
  end

  def help; end
end
