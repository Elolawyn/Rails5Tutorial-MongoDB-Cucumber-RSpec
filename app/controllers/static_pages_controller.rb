class StaticPagesController < ApplicationController
	
  def home
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
      @micropost  = current_user.microposts.build
    end
  end
  
  def help
  end

  def contact
  end

  def about
  end
end
