class Api::V1::AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:update]

  def update
    if @announcement.update(announcement_params)
      render json: AnnouncementSerializer.new(@announcement).serializable_hash.to_json
    else
      render json: @announcement.errors, status: :unprocessable_entity
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
