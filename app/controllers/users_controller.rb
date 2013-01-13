class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @adverts = @user.adverts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role_id = 2
    if @user.save
      sign_in @user
      flash[:success] = "Thank You for registration!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end
end
