class Admin::ProductsController < Admin::BaseController
  before_action :find_product_by_id, except: %i(index new create)

  def index
    if params
      @products = Product
      filtering_params(params).each do |key, value|
        if value.present?
          @products = @products.public_send("filter_by_#{key}", value)
        end
      end
    else
      @products = Product.all
    end
    @pagy, @products = pagy @products.newest, items: Settings.pagy.item_5
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

  def edit; end

  def update
    if @product.update product_params
      flash[:success] = t ".success"
      redirect_to admin_products_path
    else
      flash[:error] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t ".success"
    else
      flash[:error] = t ".failed"
    end
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product)
          .permit(Product::PRODUCT_ATTRS)
  end

  def find_product_by_id
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:error] = t ".not_found"
    redirect_to admin_products_path
  end

  def filtering_params params
    params.slice(:starts_with, :price_lower, :price_higher)
  end
end
