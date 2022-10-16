class TypesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
     types= Type.all
     render json: types
  end

  def show
    type = Type.find(params[:id])
    render json: type
  end

  def create
    type = Type.new(name: params[:name], price: params[:price], unit: params[:unit], category_id: params[:category_id])

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
      redirect_to type
    else
      render json: type.errors, status: :unprocessable_entity
    end
  end
end
