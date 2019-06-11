class TweetsController < ApplicationController

  # before_action :move_to_index, except: [:index, :show]

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at desc")
  end

  def new
  end

  def create
    Tweet.create(tweet_params)
  end

  def edit
    set_tweet
  end

  def update
    set_tweet
    @tweet.update(tweet_params) if @tweet.user_id == current_user.id
  end

  def destroy
    set_tweet
    @tweet.destroy if @tweet.user_id == current_user.id
  end

  def show
    set_tweet
    @comments = @tweet.comments.includes(:user)
  end

  private
  def tweet_params
    params.permit(:image, :text).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
