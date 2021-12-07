class Api::V1::SlidesController < ApplicationController
  before_action :authorize_request, only: [:index]

  def index
    if admin?(@current_user)
      @slides = Slide.all
      render json: SlidesSerializer.new(@slides).serializable_hash.to_json
    else
      render json: {msg: 'You are not authorized to perform that action'}, status: :forbidden
    end
  end
end
