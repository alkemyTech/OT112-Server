class Api::V1::AnnouncementsController < ApplicationController
  before_action :authorize_request

  def show
    @announcement = Announcement.find(params[:id])
    render json: AnnouncementSerializer.new(@announcement).serializable_hash.to_json
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    if @announcement.destroy
      head :no_content
    else
      render json: @announcement.errors, status: 422
    end
  before_action :authorize_request, only: [:create]

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      render json: AnnouncementSerializer.new(@announcement).serializable_hash.to_json
    else
      render json: @announcement.errors, status: :unprocessable_entity
    end  
  end

  private

  def announcement_params
    params.permit(:image, :name, :content, :category_id)
  end
end
