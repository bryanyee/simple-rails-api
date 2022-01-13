# rails generate controller Greetings hello
class GreetingsController < ApplicationController
  def hello
    data = { num: 5, str: 'hello', pet: Pet.first }
    render json: data
  end

  def world
    render json: { success: true }
  end

  def index
    render json: ['hello', 'there']
  end

  def show
    render json: { value: 'hello' }
  end

  # For CREATE/PUT/PATCH requests, params in the request body are made available in params[:resource]
  def create
    render json: params[:greeting], status: :created
  end
end
