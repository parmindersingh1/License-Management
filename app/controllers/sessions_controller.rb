class SessionsController < ApplicationController
  layout "signin" ,:only=>[:new,:create]
  def new
    
  end
  
  def create
    puts "the params are #{params}"
    user=User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
      # redirect_to => :controller=>"users", :action=> "show"
    else
     flash.now[:notice] = 'Invalid email/password combination' # Not quite right!
     render 'new'
    end
    
  end
  
  def destroy
    sign_out
    redirect_to root_url
    
  end
end
