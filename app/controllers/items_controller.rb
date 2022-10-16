class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
     items= Item.all
     render json: items
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    item = Item.new(name: params[:name], store_id: params[:store_id])

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
