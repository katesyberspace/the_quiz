class GamesUsersController < ApplicationController

	def create
		#hardcoded to user, later change to current_user
		@user = User.find_by(name: 'Kate')
		@game = Game.find_by(code: params[:code])
		if @game
			@games_user = GamesUser.new
			@games_user.user_id = @user.id
			@games_user.game_id = @game.id
			redirect_to "/games/#{ @game.id }"
		else
			redirect_to "/games/new"
		end 
	end

end
