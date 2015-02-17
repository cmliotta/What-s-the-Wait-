class Api::PatronController < ApplicationController
  before_action :validate_token

  private
  def validate_token
    secret = ‘secret’ # must be an environment variable
    begin
      token = request.headers['Authorization'].split(' ').last
      JWT.decode(token, 'secret')
    rescue JWT::DecodeError
      head :unauthorized
    end
  end
end
