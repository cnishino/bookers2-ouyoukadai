class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.created_today #今日の投稿数
    @yesterday_book = @books.created_yesterday #昨日の投稿数
    @day2_ago_boo = @books.created_2day_ago #2日前の投稿数
    @day3_ago_book = @books.created_3day_ago #3日前の投稿数
    @day4_ago_book = @books.created_4day_ago #4日前の投稿数
    @day5_ago_book = @books.created_5day_ago #5日前の投稿数
    @day6_ago_book = @books.created_6day_ago #6日前の投稿数
    @this_week_book = @books.created_this_week #今週の投稿数
    @last_week_book = @books.created_last_week #先週の投稿数
  end

  def index
    @users = User.where.not(id: current_user.id)
    @book = Book.new
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
