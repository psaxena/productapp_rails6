class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index

    #Check and Validate currency query parameter
    currency = valid_currency(params[:currency])
    if currency.nil?
      render json: { status: :unprocessable_entity, description: "Currency '#{params[:currency]}' is not supported" }
    else
      @products = Product.active
      render json: @products.to_json(:currency => currency)
    end
  end

  # GET /products/1
  def show
    #Check and Validate currency query parameter
    currency = valid_currency(params[:currency])
    if currency.nil?
      render json: { status: :unprocessable_entity, description: "Currency '#{params[:currency]}' is not supported" }
    else
      #Update Views of a product when its metadat API is called
      if @product.update_view_and_save
        render json: @product.to_json(:currency => currency)
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    #Update Views of a product when its metadata API is called
    @product.mark_inactive
    if @product.save
      render json: { status: :ok, description: "Product '#{@product.name}' marked inactive. It wont be available in listing" }
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def get_most_viewed
    #Check and Validate currency query parameter
    currency = valid_currency(params[:currency])
    if currency.nil?
      render json: { status: :unprocessable_entity, description: "Currency '#{params[:currency]}' is not supported" }
    else
      limit_count = (params[:top] && params[:top].to_i.is_a?(Integer)) ? params[:top].to_i : nil
      @products = (limit_count) ? Product.active_viewed.limit(limit_count).order(views: :desc) : Product.active_viewed.order(views: :desc)
      render json: @products.to_json(:currency => currency)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :description, :views, :active)
  end

  def valid_currency(currency_param = "USD")
    return DEFAULT_CURRENCY if currency_param.nil?
    cur = currency_param.upcase
    return ALLOWED_CURRENCY.include?(cur) ? cur : nil
  end
end
