class PagesController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    # authenticate user with password
  
    if user && user.authenticate(params[:password])
      # create new session - session is a global variable hash
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
  
    else
      render :new
    end
  end

end
