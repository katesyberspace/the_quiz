class GamesController < ApplicationController

	def random_code
	   ('AA000'..'ZZ999').to_a.sample
	end

	def new
		#hardcoded to user, later change to current_user
		@user = User.find_by(name: 'Kate')
	end

	def create
		#hardcoded to user, later change to current_user
		@user = User.find_by(name: 'Kate')
		@game = Game.new
		@game.name = params[:name]
		@game.user_id = @user.id
		@game.code = random_code
		if @game.save
			@games_user = GamesUser.new
			@games_user.user_id = @user.id
			@games_user.game_id = @game.id
			@games_user.save
			redirect_to "/games/#{ @game.id }"
		else
			render :new
		end
	end

	def show
		@response = HTTParty.get("https://opentdb.com/api.php?amount=20")
		@results = @response["results"]
	end
end
