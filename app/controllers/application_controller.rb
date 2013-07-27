class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception 
  include SessionsHelper
  include ProductLicensesHelper
  helper :all 
  
  def signed_in_user
      unless signed_in?
        store_location
      redirect_to signin_url, notice: "Please sign in to access this page." 
      end
    end
   
end
