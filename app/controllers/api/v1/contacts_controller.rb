class Api::V1::ContactsController < ApplicationController
  before_action :authorize_request
  
  def index
    @contacts = Contact.all
    render json: ContactSerializer.new(@contacts).serializable_hash.to_json
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: ContactSerializer.new(@contact).serializable_hash.to_json
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  private
    def contact_params
      params.permit(:name, :email, :phone, :message)
    end


end
