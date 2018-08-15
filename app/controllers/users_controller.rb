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
    @user = helpers.current_user
    @response = @response = HTTParty.get("https://opentdb.com/api.php?amount=20&encode=url3986")
    @results = @response["results"]
  end

end
