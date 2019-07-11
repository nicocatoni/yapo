class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner?, only: [:edit, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @on_sale_products = []
    @my_products_on_sale = []
    @products.each do |product|
      if current_user == nil
        @on_sale_products.push(product)
      elsif (current_user.id != product.user.id) && (product.sold == false)
        @on_sale_products.push(product)
      elsif current_user.id == product.user.id && product.sold == false
        @my_products_on_sale.push(product)
      end
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    redirect_to root_path, notice: 'Solo puedes modificar productos propios' if owner? == false

  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user = current_user
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def owner?
      @product.user_id == current_user.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
