class PropertiesController < ApplicationController
  before_action :set_property, only: [:edit, :update, :destroy]

  respond_to :json

  def index
    @q = current_user.properties.includes(:current_lease).ransack(params[:q])
    @properties = @q.result
    respond_with(@properties)
  end

  def show
    @property = current_user.properties.includes(:current_lease).find(params[:id])
    respond_with(@property)
  end

  def create
    @property = current_user.properties.build(property_params)
    @property.save
    respond_with(@property)
  end

  def update
    @property.update(property_params)
    respond_with(@property)
  end

  def destroy
    @property.destroy
    respond_with(@property)
  end

  private
    def set_property
      @property = current_user.properties.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:name, :address_line_1, 
        :address_line_2, :city, :state, :postal_code, :beds, :baths, :size)
    end
end
