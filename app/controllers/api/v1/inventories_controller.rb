class Api::V1::InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :update, :destroy]
  
  def index
    @inventories = Inventory.all
    render json: @inventories
  end

  def show
    render json: @inventory
  end

  def create
    @inventory = Inventory.new(inventory_params)
    
    if @inventory.save
      render json: @inventory, status: :created
    else
      render json: { errors: @inventory.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @inventory.update(inventory_params)
      render json: @inventory
    else
      render json: { errors: @inventory.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @inventory.destroy
    head :no_content
  end
  
  private
  
  def set_inventory
    @inventory = Inventory.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Inventory not found' }, status: :not_found
  end
  
  def inventory_params
    params.require(:inventory).permit(:sku, :name, :description, :quantity, :price, :location, :supplier)
  end
end
