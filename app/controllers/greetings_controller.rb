# rails generate controller Greetings hello
class GreetingsController < ApplicationController
  def hello
    data = { num: 5, str: 'hello', pet: Pet.first }
    render json: data
  end
end
