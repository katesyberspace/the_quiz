class GamesController < ApplicationController


	def random_code
	   ('AA000'..'ZZ999').to_a.sample
	end

	def new
		@user = helpers.current_user
	end

	def create
		@user = helpers.current_user
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
	
		# make sure the records are being updated
		user_records = GamesUser.where(game_id: params[:id]) 
		@users =[]
		user_records.each do |user_record|
			@users << User.find_by(id: user_record.user_id)
		end

		@game = Game.find(params[:id]) 
	end


	def start
		@game = Game.find(params[:id])
		user_records = GamesUser.where(game_id: params[:id])
		@users =[]
		user_records.each do |user_record|
			@users << User.find_by(id: user_record.user_id)
		end
		@response = HTTParty.get("https://opentdb.com/api.php?amount=20&encode=url3986")
		@results = @response["results"]
		SseRailsEngine.send_event('game-start', { kate: 'gitlord' })
		
		render :show
	end


end

