class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:edit, :update, :destroy]

  respond_to :json

  def index
    @q = Invoice.ransack(params[:q])
    @invoices = @q.result
    respond_with(@invoices)
  end

  def show
    @invoice = Invoice.find(params[:id])
    respond_with(@invoice)
  end

  def create
    @invoice = Invoice.build(invoice_params)
    @invoice.save
    respond_with(@invoice)
  end

  def update
    @invoice.update(invoice_params)
    respond_with(@invoice)
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice)
  end

  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:name, :email)
    end
end
