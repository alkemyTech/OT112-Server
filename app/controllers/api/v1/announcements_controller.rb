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
  end
end
