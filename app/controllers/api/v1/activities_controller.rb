class Api::V1::ActivitiesController < ApplicationController
  # POST /api/v1/activities
  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      render json: @activity, status: :created
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  private
    def activity_params
      params.permit(:name, :content)
    end
end
