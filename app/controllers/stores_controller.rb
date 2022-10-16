class StoresController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
     stores= Store.all
     render json: stores
  end

  def show
    store = Store.find(params[:id])
    render json: store
  end

  def create
    store = Store.new(name: params[:name], user_id: params[:user_id])

    if store.save
      render json: store, status: :created
    else
      render json: store.errors, status: :unprocessable_entity
    end
  end

  def destroy
    store = Store.find(params[:id])
    store.destroy
    redirect_to stores_path, status: :see_other
  end
end
