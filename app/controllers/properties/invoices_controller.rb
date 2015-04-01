class Properties::InvoicesController < ApplicationController
  before_action :set_property
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @q = @property.invoices.ransack(params[:q])
    @invoices = @q.result
    respond_with(@property, @invoices)
  end

  def show
    respond_with(@property, @invoice)
  end

  def create
    @invoice = @property.invoices.build(invoice_params)
    @invoice.save
    respond_with(@property, @invoice, location: nil)
  end

  def update
    @invoice.update(invoice_params)
    respond_with(@property, @invoice, location: nil)
  end

  def destroy
    @invoice.destroy
    respond_with(@property, @invoice)
  end

  private
    def set_property
      @property = current_user.properties.find(params[:property_id])
    end

    def set_invoice
      @invoice = @property.invoices.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:start_date, :end_date, :frequency, :interval, :deposit, :rent)
    end
end
