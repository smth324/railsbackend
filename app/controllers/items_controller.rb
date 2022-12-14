class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def check_ownership
    unless current_user.id == Item.find(params[:id]).store.user_id || current_user.store_id == Item.find(params[:id]).store.id
      head :unauthorized
    end
  end

  def index
     items= Item.all.filter{|item| item.store.user_id == current_user.id || item.store.id == current_user.store_id}
     render json: items
  end

  def new
    @item = Item.new
  end

  def show
    item = Item.find(params[:id])
    render json: item.to_json(include:  {categories: {include: :types} })
  end

  def create
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
      render json: item
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end
end
