class SessionsController < ApplicationController
  layout "signin" ,:only=>[:new,:create]
  before_filter :signed_in_user, :only=>[:change_password]
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
  
  def recovery
    puts "the params are #{params}"
    unless params[:login_email].nil?
      @user=User.find_by_email(params[:login_email])
      if @user.nil?
        render :json => {:valid => false, :notice => "User Not found for this Email "}
      else
        chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
        newpass = ""
        1.upto(20) { |i| newpass << chars[rand(chars.size-1)] }
        @subject = "Reset password"
        @body = "Your new password is "+ newpass
        if @user.update_attributes(:password => newpass)
          begin
          UserMailer.registration_confirmation(@user,@subject,@body).deliver
        rescue Exception => exec
          render :json => {:valid => false, :notice => "Password has been reset but email nit sent."}
       else
          render :json => {:valid => true, :notice => "Password has been reset successfully. Please check mail for new password."}
       end
       
        end
      end
    else
      render :json => {:valid => false, :notice => "This User Name does not exist!"}     
    end
  end
  
  def change_password
    puts "the params are #{params}"
    puts "current user #{current_user.email}"
    unless params[:new_pass].length < 6
      user = User.find_by_email(current_user.email)
      if user && user.authenticate(params[:old_pass])
        if user.update_attributes(:password=>params[:new_pass])
          render :json => {:valid => true, :notice => "You have successfully changed your password"}
        else
          render :json => {:valid => false, :notice => "error in password updation"}
        end
      else
        render :json => {:valid => false, :notice => "Current password not matched"}
      end
      
    else
      render :json => {:valid => false, :notice => "New password must be minimum six charector long"}
    end
  end

end
