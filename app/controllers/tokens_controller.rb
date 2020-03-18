class TokensController < ApplicationController
  def login
    user = User.where(email: params.dig(:email)).first

    if user&.authenticate(params.dig(:password))
      payload = { name: user.name, surname: user.surname, email: user.email }
      payload[:exp] = Time.now.to_i + (params[:expiry].to_i * 24 * 3_600) if params[:expiry].to_i.positive?

      token = JWT.encode(payload, ::File.read('.token_secret'), 'HS512')

      json_response({ token: token }, 200)
    else
      json_response({ errors: { login: 'YOU HAVE FAILED THE TEST OF LIFE AND THINGS!!' } })
    end
  end
end
