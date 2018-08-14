class UsersController < ApplicationController
  def create
    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.password = params[:password]
    if user.save
      # log the user in
      session[:user_id] = user.id
      redirect_to "/games/new"
    else
      redirect_to '/'
    end
  end

  def show
  end



end
