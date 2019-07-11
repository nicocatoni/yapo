class SalesController < ApplicationController
before_action :authenticate_user!
before_action :sales_params, :find_product, except: [:index]
  def index
    @total = 0
    @sales = Sale.all
    @my_bought_products = []
    @sales.each do |sale|
      if sale.user_id == current_user.id
        @my_bought_products.push(sale.product)
      end
    end
  end

  def create
    @sale = Sale.new
    @sale.product_id = @product_id
    @sale.user_id = @user_id
    @sale.save
    product_sold
    redirect_to root_path, notice: 'La compra se ha realizado exitosamente'
  end

  private
  def sales_params
    @product_id = params[:parameters]['id']
    @user_id = current_user.id

  end

  def find_product
    @product = Product.find((params[:parameters]['id']).to_i)
  end

  def product_sold
    @product.sold = true
    @product.save
  end

end
