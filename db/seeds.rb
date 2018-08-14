Game.destroy_all
User.destroy_all
GamesUser.destroy_all

def random_code
   ('AA000'..'ZZ999').to_a.sample
end

kate = User.create(name: 'Kate', password: 'pudding', email: 'k@k.com')
megan = User.create(name: 'Megan', password: 'pudding', email: 'm@m.com')
fran = User.create(name: 'Fran', password: 'pudding', email: 'f@f.com')

game1 = Game.create(name: 'Test1', code: random_code, user_id: User.find_by(name: 'Kate').id)

user_record1 = GamesUser.create(user_id: User.find_by(name: 'Kate').id, game_id: Game.find_by(name: 'Test1').id, score: 0)
user_record2 = GamesUser.create(user_id: User.find_by(name: 'Megan').id, game_id: Game.find_by(name: 'Test1').id, score: 0)
user_record3 = GamesUser.create(user_id: User.find_by(name: 'Fran').id, game_id: Game.find_by(name: 'Test1').id, score: 0)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
