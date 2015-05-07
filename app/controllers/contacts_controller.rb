class ContactsController < ApplicationController
  before_action :set_contact, only: [:edit, :update, :destroy]

  respond_to :json

  def index
    @q = Contact.ransack(params[:q])
    @contacts = @q.result
    respond_with(@contacts)
  end

  def show
    @contact = Contact.find(params[:id])
    respond_with(@contact)
  end

  def create
    @contact = Contact.build(contact_params)
    @contact.save
    respond_with(@contact)
  end

  def update
    @contact.update(contact_params)
    respond_with(@contact)
  end

  def destroy
    @contact.destroy
    respond_with(@contact)
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email)
    end
end
