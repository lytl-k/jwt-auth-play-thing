class TokensController < ApplicationController
  def login
    user = User.where(email: params.dig(:email)).first

    if user&.authenticate(params.dig(:password))
      payload = { name: user.name, surname: user.surname, email: user.email }
      payload[:exp] = Time.now.to_i + (params[:expiry].to_i * 24 * 3_600) if params[:expiry].to_i.positive?

      token = JWT.encode(payload, ::File.read('.token_secret'), 'HS512')

      json_response({ token: token }, 200)
    else
      json_response({ errors: { login: 'YOU HAVE FAILED THE TEST OF LIFE AND THINGS!!' } }, 401)
    end
  end

  def info
    token = params[:token]
    return json_response({ errors: { token: ['is needed as a parameter'] } }, 400) unless token

    token_data = JWT.decode token, ::File.read('.token_secret'), true, { algorithm: 'HS512' }
    token_data.first[:parsed_exp] = Time.at(token_data.first['exp']) if token_data.first['exp']

    json_response token: token_data
  end
end
