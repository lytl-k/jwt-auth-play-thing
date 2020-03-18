class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.valid?
      user.save
      json_response({ message: 'success... We think...' }, 201)
    else
      json_response({ errors: user.errors.messages }, 500)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  end
end
