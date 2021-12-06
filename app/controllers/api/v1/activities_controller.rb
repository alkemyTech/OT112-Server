class Api::V1::ActivitiesController < ApplicationController
  before_action :authorize_request

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      render json: ActivitySerializer.new(@activity).serializable_hash.to_json, status: :created
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  private

  def activity_params
    params.permit(:name, :content)
  end
end
