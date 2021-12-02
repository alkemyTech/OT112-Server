class Api::V1::AnnouncementsController < ApplicationController
  before_action :authorize_request

  def show
    @announcement = Announcement.find(params[:id])
    render json: AnnouncementSerializer.new(@announcement).serializable_hash.to_json
  end

  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.type = "news"
    @announcement.category = Category.create_or_find_by(name: 'news', description: 'news category')
    if @announcement.save
      render json: AnnouncementSerializer.new(@announcement).serializable_hash.to_json
    else
      render json: @announcement.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    if @announcement.destroy
      head :no_content
    else
      render json: @announcement.errors, status: 422
    end
  end

  private

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.permit(:image, :name, :content, :category_id)
  end
end
