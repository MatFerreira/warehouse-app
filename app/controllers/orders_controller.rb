class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = Order.find params[:id]
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new order_params
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = 'Não foi possível registrar o pedido'
      render :new
    end
  end

  def search
    @code = params[:query]
    @order = Order.find_by(code: @code)
  end
end
