class StaticPagesController < ApplicationController
  skip_before_action :redirect_if_not_logged_in
  skip_before_action :redirect_if_incorrect_user

  def home
  end

  def help
  end

  def about
  end

  def contact
  end
end
