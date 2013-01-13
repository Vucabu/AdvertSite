class SiteController < ApplicationController
  def home
    if signed_in?
      @advert  = current_user.adverts.build
    end
    if(params[:category].to_i == 0)
      @feed_items = Advert.paginate(page: params[:page])
    else
      @feed_items = Advert.where(:category_id => params[:category]).paginate(page: params[:page])
    end
  end

  def admin
    @admin_feed_items = []
    if admin?
      @admin_feed_items = Advert.paginate(page: params[:page])
    end
  end
end
