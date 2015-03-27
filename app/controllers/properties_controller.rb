class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @q = current_user.properties.ransack(params[:q])
    @properties = @q.result
    respond_with(@properties)
  end

  def show
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
        :address_line_2, :city, :state, :zip_code, :number_of_units, 
        :purchase_price, :purchased_on, :property_type,
        units_attributes: [:name, :beds, :baths, :square_footage, :_destroy, :id])
    end
end
