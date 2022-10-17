class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership, only: [:destory, :update, :show]
  skip_before_action :verify_authenticity_token

  def check_ownership
    unless current_user.id == Item.find(params[:id]).store.user_id
      head :unauthorized
    end
  end

  def index
     items= Item.all.filter{|item| item.store.user_id == current_user.id}
     render json: items
  end

  def new
    @item = Item.new
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    unless current_user.id == Store.find(params[:item][:store_id]).user_id
      head :unauthorized
    end
    item = Item.new(name: params[:item][:name], store_id: params[:item][:store_id])

    if item.save
      render json: item, status: :created
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path, status: :see_other
  end

  def update
    item = Item.find(params[:id])
    if item.update(name: params[:name])
      redirect_to item
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end
end
