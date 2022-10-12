class StoresController < ApplicationController
  def index
    @stores = User.all
  end

  def show
    @store = User.find(params[:id])
  end

  def new
    @store = User.new
  end

  def create
    @store = User.new(user_params)

    if @store.save
      redirect_to @store
    else
      render :new, status: :unprocessable_entity
    end
  end
  private
  def user_params
    params.require(:store).permit(:name)
  end
end
