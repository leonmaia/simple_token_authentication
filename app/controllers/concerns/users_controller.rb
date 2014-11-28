class UsersController < ApplicationController
  before_action :authenticate, except: [:create]

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.to_json(:methods => [:auth_token])
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      render json: @user
    else
      render json: { message: "User not found" }.to_json, status: 404
    end
  end

  def user_params
    params.permit(:email, :password)
  end
end
