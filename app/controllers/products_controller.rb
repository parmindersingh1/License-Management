class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  before_filter :signed_in_user
  def index
    @products = Product.find(:all,:conditions=>{:is_deleted => false})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    puts params
    old_product = Product.find_by_name_and_is_deleted(params[:product][:name],true)
    unless old_product.nil?
      old_product.update_attributes(:version=>params[:product][:version],:release_date=>params[:product][:release_date],:is_deleted=>false)
      respond_to do |format|
       format.html { redirect_to products_url }
      end     
    else
      @product = Product.new(params[:product])
      @product.is_deleted = false
   
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_url }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def delete_product
    puts "params in destroy controller is #{params}"
    @key_assigned = false
    params[:products].each do |product|
      @product = Product.find_by_id(product)
      @product.product_licenses.each do |license|
        if license.is_assigned
          @key_assigned = true
          break
        else
          @key_assigned = false
        end
      end
    end
    puts "the errors are #{@key_assigned}"
    if @key_assigned
      render :json=> {:valid=>false, :notice=>"Dependency Error .This keys are assigned to users"}
    else
      @product.update_attributes(:is_deleted=>true)
      render :json=> {:valid=>true, :notice=>"Product deleted successfully. Please Refresh page."}
      
    end
  end

  
  def reset_requests
    
  end
  
  def search_email
     puts "the parama are #{params}"
     @searched_emails = ProductLicense.find_by_email(params[:email])
     render :partial => "searched_emails"  
  end
  def allow_regeneration
    puts "params are #{params}"
    unless params[:key].nil?
      params[:keys].each do |key|
        license = ProductLicense.find_by_id(key)
        license.update_attributes(:allow_regeneration=>true)
      end
    end
    render :text => "Keys Reset Successfully"  
  end
end
