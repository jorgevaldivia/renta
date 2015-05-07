class PropertiesController < ApplicationController
  before_action :set_property, only: [:edit, :update, :destroy]

  respond_to :json

  def index
    @q = Property.includes({current_lease: {leases_users: :contact}}).ransack(params[:q])
    @properties = @q.result
    respond_with(@properties)
  end

  def show
    @property = Property.
      includes({current_lease: [{leases_users: :contact}, :next_invoice]}).
        find(params[:id])
    respond_with(@property)
  end

  def create
    @property = Property.build(property_params)
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
      @property = Property.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:name, :address_line_1, 
        :address_line_2, :city, :state, :postal_code, :beds, :baths, :size)
    end
end
