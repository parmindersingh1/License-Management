class UsersController < ApplicationController
  layout "signin", :only=>[:forgot_password]
 #before_filter :signed_in_user ,:except => [:new,:create]
 before_filter :signed_in_user, only: [:index,:edit, :update]
 before_filter :correct_user,   only: [:edit, :update]
  # GET /users
  # GET /users.json
  def index

    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new

    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted successfully."
    redirect_to users_url
  end
  
  def forgot_password
    # puts "the params are #{params}"
    # unless params[:email].nil?
      # @user=User.find_by_email(params[:email][:id])
      # if @user.nil?
        # flash.now[:error]="User not found for this email"
      # else
        # chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
        # newpass = ""
        # 1.upto(20) { |i| newpass << chars[rand(chars.size-1)] }
        # @subject = "Reset password"
        # @body = "Your new password is "+ newpass
         # if @user.update_attributes(:password => newpass)
           # UserMailer.registration_confirmation(@user,@subject,@body).deliver
           # flash.now[:notice]="Password reset successfully please check your mail"
         # end
      # end
      # else
        # flash.now[:error]="Please enter your email..."
    # end
  end
 
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
      redirect_to signin_url, notice: "Please sign in to access this page." 
      end
    end
    
     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

  
end
