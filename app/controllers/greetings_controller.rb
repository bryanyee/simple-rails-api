# rails generate controller Greetings hello
class GreetingsController < ApplicationController
  def hello
    data = { num: 5, str: 'hello' }
    render json: data
  end
end
