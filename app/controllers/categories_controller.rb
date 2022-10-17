class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership, only: [:destory, :update, :show]
  skip_before_action :verify_authenticity_token

  def check_ownership
    unless current_user.id == Category.find(params[:id]).item.store.user_id
      head :unauthorized
    end
  end

  def index
     categories= Category.all.filter{|category| category.item.store.user_id == current_user.id}
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
    unless current_user.id == Item.find(params[:category][:item_id]).store.user_id
      head :unauthorized
    end
    category = Category.new(name: params[:category][:name], item_id: params[:category][:item_id])

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
