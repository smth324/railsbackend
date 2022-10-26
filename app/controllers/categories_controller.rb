class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def check_ownership
    unless current_user.id == Category.find(params[:id]).item.store.user_id || current_user.store_id == Category.find(params[:id]).item.store.id
      head :unauthorized
    end
  end

  def index
     categories= Category.all.filter{|category| category.item.store.user_id == current_user.id || category.item.store.id == current_user.store_id}
     render json: categories
  end

  def new
    @category = Category.new
  end

  def show
    category = Category.find(params[:id])
    render json: category
  end

  def create
    category = Category.new(name: params[:category][:name], item_id: params[:category][:item_id])

    if category.save
      render json: category.to_json(include:  :types), status: :created
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
      render json: category.to_json(include:  :types)
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end
end
