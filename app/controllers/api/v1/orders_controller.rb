class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  
  def index
    @orders = Order.includes(:order_items, :inventories).all
    render json: @orders, include: [:order_items, :inventories]
  end

  def show
    render json: @order, include: [:order_items, :inventories]
  end

  def create
    @order = Order.new(order_params)
    
    if @order.save
      create_order_items if params[:order_items].present?
      render json: @order, include: [:order_items, :inventories], status: :created
    else
      render json: { errors: @order.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order, include: [:order_items, :inventories]
    else
      render json: { errors: @order.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    head :no_content
  end
  
  private
  
  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Order not found' }, status: :not_found
  end
  
  def order_params
    params.require(:order).permit(:customer_name, :customer_email, :status, :total_amount, :shipped_date)
  end
  
  def create_order_items
    params[:order_items].each do |item_params|
      inventory = Inventory.find(item_params[:inventory_id])
      @order.order_items.create!(
        inventory: inventory,
        quantity: item_params[:quantity],
        unit_price: item_params[:unit_price] || inventory.price
      )
    end
  end
end
