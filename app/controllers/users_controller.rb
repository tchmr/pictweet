class UsersController < ApplicationController

  def show
    @nickname = User.find(params[:id]).nickname
    @tweets = User.find(params[:id]).tweets.page(params[:page]).per(5).order("created_at DESC")
  end

end
