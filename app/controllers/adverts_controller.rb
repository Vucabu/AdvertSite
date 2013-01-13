class AdvertsController < ApplicationController
  before_filter :correct_user,   only: :destroy
  def new
    @advert = current_user.adverts.build(params[:advert])
  end

  def create
    @advert = current_user.adverts.build(params[:advert])
    if @advert.save
      flash[:success] = "Advert created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'adverts/new'
    end
  end

  def destroy
    if admin?
      Advert.find(params[:id]).destroy
      redirect_to admin_path
    else
      @advert.destroy @advert
      redirect_to root_url
    end
  end

  def edit
    @advert = Advert.find(params[:id])
  end

  def update
    @advert = Advert.find(params[:id])
    if @advert.update_attributes(params[:advert])
      flash[:success] = "Advert updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

  def correct_user
    @advert = current_user.adverts.where(:id => params[:id])
    redirect_to root_url if @advert.nil?
  end
end
