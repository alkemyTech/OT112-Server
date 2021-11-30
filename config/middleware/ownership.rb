class Ownership
  def initialize app
    @app = app
  end

  def call env
    @status, @headers, @response = @app.call(env)
    
    token = env.select {|k,v| k.start_with? 'HTTP_AUTHORIZATION'}
    .collect {|key, val| [key.sub(/^HTTP_AUTHORIZATION/, ''), val]}
    .collect {|key, val| "#{val.split.last}"}
    .sort
    .flatten
    [200, {'Content-Type' => 'text/html'}, token]

    # user_id = AuthTokenService.decode(token)

  end

end