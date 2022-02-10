# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Pets
Pet.create(name: 'Bob', age: 5)

# Users
user0 = User.create(first_name: 'Sam', last_name: 'Smith', username: 'sammys')
user1 = User.create(first_name: 'Bob', last_name: 'Ross', username: 'happytrees')
User.create(first_name: 'Joe', last_name: 'Shmo', username: 'shmack')
User.create(first_name: 'Kyle', last_name: 'Shmo')
User.create(first_name: 'Steve', last_name: 'Jobs')
User.create(first_name: 'Steve', last_name: 'Rogers')

# Posts
Post.create(text: 'hello world', user: user1, kind: 0)
Post.create(text: 'second', user: user1, kind: 1)
