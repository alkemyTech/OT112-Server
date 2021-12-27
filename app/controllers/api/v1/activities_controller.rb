class Api::V1::ActivitiesController < ApplicationController
  before_action :authorize_request
  before_action :admin?
  before_action :set_activity, only: [:update]

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      render json: ActivitySerializer.new(@activity).serializable_hash.to_json, status: :created
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  def update
    if @activity.update(activity_params)
      render json: ActivitySerializer.new(@activity).serializable_hash.to_json, status: :ok
    else
      render json: @activity.errors
    end
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Could not find activity with ID '#{params[:id]}'"}
  end

  def activity_params
    params.permit(:name, :content)
  end
end
