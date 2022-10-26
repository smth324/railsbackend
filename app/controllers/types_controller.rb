class TypesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def check_ownership
    unless current_user.id == Type.find(params[:id]).category.item.store.user_id || current_user.store_id == Type.find(params[:id]).category.item.store.id
      head :unauthorized
    end
  end

  def new
    @type = Type.new
  end

  def index
     types= Type.all.filter{|type| type.category.item.store.user_id == current_user.id || type.category.item.store.id == current_user.store_id}
     render json: types
  end

  def show
    type = Type.find(params[:id])
    render json: type
  end

  def create
    type = Type.new(name: params[:type][:name], price: params[:type][:price], unit: params[:type][:unit], category_id: params[:type][:category_id])

    if type.save
      render json: type, status: :created
    else
      render json: type.errors, status: :unprocessable_entity
    end
  end

  def destroy
    type = Type.find(params[:id])
    type.destroy
    redirect_to types_path, status: :see_other
  end

  def update
    type = Type.find(params[:id])
    if type.update(name: params[:name], price: params[:price], unit: params[:unit])
      render json: type
    else
      render json: type.errors, status: :unprocessable_entity
    end
  end
end
