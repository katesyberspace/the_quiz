class GamesUsersController < ApplicationController
	
	def show
		@game = Game.find(params[:id])
		render :win
	end

	def create
		@user = helpers.current_user
		@code = params[:code].upcase
		@game = Game.find_by(code: @code)
		if @game
			@games_user = GamesUser.new
			@games_user.user_id = @user.id
			@games_user.game_id = @game.id
			@games_user.save
			@second_user = true
			SseRailsEngine.send_event('users', { foo: 'bar' })

			redirect_to "/games/#{ @game.id }"
		else
			redirect_to "/games/new"
		end 
	end

	def update
		@user = helpers.current_user
		@game = Game.find_by(id: params[:id])
		user_record = GamesUser.where(game_id: params[:id]).where(user_id: @user.id)
		user_record.score = params[:score]
		raise params[:score]
		user_record.save
		num_scores_saved = GamesUser.where(game_id: params[:id]).where.not(score: nil)

		if num_scores_saved.length == 2
			SseRailsEngine.send_event('test', { scoresReceived: 'true' })
		end

		 
	end

end
