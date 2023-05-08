class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @product_models = ProductModel.all
  end

  def show
    @product_model = ProductModel.find params[:id]
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_models_params)
    if @product_model.save()
      redirect_to product_model_path(@product_model), notice: 'Modelo de produto cadastrado com sucesso'
    else
      @suppliers = Supplier.all
      flash.now[:notice] = 'Modelo de produto não cadastrado'
      render 'new'
    end
  end

  private
    def product_models_params
      params
        .require(:product_model)
        .permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
    end
end
