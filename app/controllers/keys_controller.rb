class KeysController < ApplicationController
  require 'securerandom'
  
  def display_keys
    @keys= Key.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keys }
    end
  end
  
  def generate_keys
    @error=false
    @generated_list=[]
    2.times do
      @list=SecureRandom.hex(8)
      @generated_list<<@list      
      @key=Key.new(:generated_key => @list)
      if @key.save

        else
        @error=true
      end
    end
    unless @error
      render :text=> "error"
    else
      render :text=> "created"
    end
  end
  
  
end
