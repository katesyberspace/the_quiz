class UsersController < ApplicationController
  def create
    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.password = params[:password]
    if user.save
      redirect_to "/users/#{user.id}"
    else
      redirect_to '/'
    end
  end

  def show
  end



end
