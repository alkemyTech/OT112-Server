class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }
  end
  
  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      @decoded = AuthTokenService.decode(header)
      @current_user = User.find(@decoded['user_id'])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def ownership(current_user)
    if !owner?(current_user) && !admin?(current_user)
      render json: {msg: 'You are not allowed to see this content'}, status: :forbidden
    end
  end

  def owner?(current_user)
    user.id == params[:id]
  end

  def admin?(current_user)
    user.role.name == 'admin'
  end
    
  rescue_from CanCan::AccessDenied do
    render json: {msg: 'Access denied!'}
  end
end
