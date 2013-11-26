class SessionController < ApplicationController
  def create
    session['user'] = auth_hash[:info]
    redirect_to '/'
  end

  def failure
    session['user'] = nil
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
