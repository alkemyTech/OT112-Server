class Api::V1::AnnouncementsController < ApplicationController
  before_action :authorize_request
  before_action :set_announcement, only: %i[show update destroy]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, @announcement = pagy(Announcement.all, items: params[:items] || 10, page: params[:page] || 1)
    render json: AnnouncementSerializer.new(@announcement).serializable_hash.to_json
  end

  def show
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

  def update
    if admin?(@current_user) 
      if @announcement.update(announcement_params)
        render json: AnnouncementSerializer.new(@announcement).serializable_hash.to_json
      else
        render json: @announcement.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  def destroy
    if admin?(@current_user) 
      if @announcement.destroy
        head :no_content
      else
        render json: @announcement.errors, status: 422
      end
    else
      render json: { error: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  private

  def set_announcement
    @announcement = Announcement.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Could not find announcement with ID '#{ params[:id] }'" }
  end
  

  def announcement_params
    params.permit(:image, :name, :content, :category_id, :type)
  end
end
