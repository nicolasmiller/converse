class SessionController < ApplicationController
  def create
    session['user'] = auth_hash[:info]
    redirect_to '/'
  end

  def failure
    session['user'] = nil
  end

  def token
    unless session['user']
      render json: {error: 'Authentication failure'} 
    else
      users = params[:users] ? params[:users].split(',') : session['user'][:nickname]
      users = Array(users)
      render json: Token.get_token(users).merge(for_users: users)
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
