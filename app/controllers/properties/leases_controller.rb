class Properties::LeasesController < ApplicationController
  before_action :set_property
  before_action :set_lease, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @q = @property.leases.ransack(params[:q])
    @leases = @q.result
    respond_with(@property, @leases)
  end

  def show
    respond_with(@property, @lease)
  end

  def create
    @lease = @property.leases.build(lease_params)
    @lease.save
    respond_with(@property, @lease, location: nil)
  end

  def update
    @lease.update(lease_params)
    respond_with(@property, @lease, location: nil)
  end

  def destroy
    @lease.destroy
    respond_with(@property, @lease)
  end

  private
    def set_property
      @property = current_user.properties.find(params[:property_id])
    end

    def set_lease
      @lease = @property.leases.find.find(params[:id])
    end

    def lease_params
      params.require(:lease).permit(:start_date, :end_date, :frequency, :interval, :deposit, :rent)
    end
end
