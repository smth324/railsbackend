class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
     categories= Category.all
     render json: categories
  end

  def show
    category = Category.find(params[:id])
    render json: category
  end

  def create
    category = Category.new(name: params[:name], item_id: params[:item_id])

    if category.save
      render json: category, status: :created
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to categories_path, status: :see_other
  end

  def update
    category = Category.find(params[:id])
    if category.update(name: params[:name])
      redirect_to category
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end
end
