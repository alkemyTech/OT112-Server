class Api::V1::AnnouncementsController < ApplicationController
  before_action :authorize_request
  before_action :admin?, only: %i[create update destroy]
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
    @announcement.comm_type = "news"
    @announcement.category = Category.create_or_find_by(name: 'news', description: 'news category')
    if @announcement.save
      render json: AnnouncementSerializer.new(@announcement).serializable_hash.to_json, status: :created
    else
      render json: @announcement.errors, status: :unprocessable_entity
    end
  end

  def update
    if @announcement.update(announcement_params)
      render json: AnnouncementSerializer.new(@announcement).serializable_hash.to_json, status: :created
    else
      render json: { error: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  def destroy
      @announcement.destroy
      render json: {
        status: 'Success',
        message: 'Announcement destroyed.',
        data: @announcement,
        }, status: :ok
  end

  private

  def set_announcement
    @announcement = Announcement.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Could not find announcement with ID '#{ params[:id] }'" }, status: :not_found
  end

  def announcement_params
    params.permit(:image, :name, :content, :category_id, :comm_type)
  end
end
