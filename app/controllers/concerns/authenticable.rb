module Authenticable
  def current_user
    header = request.headers['Authorization']&.split(' ')&.last
    begin
      decoded = JWT.decode(header, JWT_SECRET, true, { algorithm: 'HS256' })
      @current_user = User.find(decoded[0]['user_id'])
    rescue
      @current_user = nil
    end
  end

  def authenticate!
    render json: { error: 'unauthorized' }, status: :unauthorized unless current_user
  end
end
