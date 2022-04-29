class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # success logic, log them in
      # save the user id inside the browser cookie. The is how we keep the user
      # logged in when they navigate around the website
      session[:user_id] = user.id
      redirect_to '/'
    else
      # if the user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
  
end
