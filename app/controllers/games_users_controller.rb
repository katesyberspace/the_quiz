class GamesUsersController < ApplicationController
	
	def show
		if helpers.logged_in?
			@game = Game.find(params[:id])
			render :win
		else
			redirect_to '/'		
		end

	end

	def create
		@user = helpers.current_user
		@code = params[:code].upcase
		@game = Game.find_by(code: @code)
		if @game
			# limit two users joining a game
			num_players_in_game = GamesUser.where(game_id: @game.id).length
			if num_players_in_game < 2
				if GamesUser.find_by(user_id: @user.id, game_id: @game.id)
				else
					@games_user = GamesUser.new
					@games_user.user_id = @user.id
					@games_user.game_id = @game.id
					@games_user.save
					@second_user = true
					SseRailsEngine.send_event('users', { foo: 'bar' })

					redirect_to "/games/#{ @game.id }"
				end
			else
				redirect_to '/games/new' 
			end
		else
			redirect_to "/games/new"
		end 
	end

	def update
		@user = helpers.current_user
		@game = Game.find_by(id: params[:id])
		user_record = GamesUser.where(game_id: params[:id]).find_by(user_id: @user.id)
		user_record.score = params[:score]
		user_record.save
		num_scores_saved = GamesUser.where(game_id: params[:id]).where.not(score: nil)

		if num_scores_saved.length == 2
			SseRailsEngine.send_event('test', { scoresReceived: 'true' })
		end

		 
	end

end
