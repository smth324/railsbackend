class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
     users= User.all
     render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(email: params[:email], password: params[:password])

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
