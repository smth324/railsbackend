class TypesController < ApplicationController
  def index
    @types = Type.all
  end

  def show
    @type = Type.find(params[:id])
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(category_params)

    if @type.save
      redirect_to @type
    else
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    @type = Type.find(params[:id])
    @type.destroy
    redirect_to types_path, status: :see_other
  end
  private
  def category_params
    params.require(:type).permit(:name, :category_id)
  end
end
