class Admin::ProductsController < Admin::BaseController
  def index
    @pagy, @products = pagy Product.all.newest, items: Settings.pagy.items
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".success"
      redirect_to admin_products_path
    else
      flash.now[:error] = t ".error"
      render :new
    end
  end

  private
  def product_params
    params.require(:product)
          .permit(Product::PRODUCT_ATTRS)
  end
end
