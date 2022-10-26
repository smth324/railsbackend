class StoresController < ApplicationController
  skip_before_action :verify_authenticity_token

  def check_ownership
    unless current_user.id == Store.find(params[:id]).user_id || current_user.store_id == Store.find(params[:id]).id
      head :unauthorized
    end
  end

  def new
    @store = Store.new
  end

  def index
     stores = Store.all.filter{|store| store.user_id == current_user.id || store.id === current_user.store_id}
     render json: stores
  end

  def show
    store = Store.find(params[:id])
    render json: store.to_json(:include => :items)
  end

  def create
    store = Store.new(name: params[:store][:name], user_id: current_user.id)
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
