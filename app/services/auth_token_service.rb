class AuthTokenService
  def self.call(user_id)
    id = { user_id: user_id }
    JWT.encode({
                id: id,
                exp: 3.hours.from_now.to_i 
      }, ENV['HMAC_SECRET'], ENV['ALGORITHM_TYPE'])
  end

  def self.decode(token)
    decoded_token = JWT.decode token, ENV['HMAC_SECRET'], true, { algorithm: ENV['ALGORITHM_TYPE'] }
    decoded_token[0]['id']
  end
end 