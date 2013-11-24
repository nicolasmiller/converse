class MainController < ApplicationController
  def index
    redirect_to '/auth/twitter' unless session['user']
  end
end
