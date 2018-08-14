class UsersController < ApplicationController
  def create
    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.password = params[:password]
    if user.save
      redirect "/users/#{user.id}"
    else
      render :new
    end
  end

end
