class UsersController < ApplicationController
  before_action :authenticate_user!

  def sold_products
    @sales = Sale.all
    @my_sales = []
    @sales.each do |sale|
      if sale.product.user == current_user
        @my_sales.push(sale)
      end
    end
  end

  def show
    sold_products
    @user = User.find(params[:id])
  end
end
