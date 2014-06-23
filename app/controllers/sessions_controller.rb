class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    if session[:user_id]
      # Means our user is signed in. Add the authorization to the user
      User.find(session[:user_id]).add_provider(auth_hash)

      redirect_to root_path, notice: "You can now login using #{auth_hash["provider"].capitalize} too!"
    else
      # Log him in or sign him up
      auth = Authorization.find_or_create(auth_hash)

      # Create the session
      session[:user_id] = auth.user.id

      redirect_to root_path, notice: "Welcome #{auth.user.name}!"
    end
  end

  def failure
    redirect_to login_path, alert: "Sorry, but you didn't allow access to our app!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You've logged out!"
  end
end
