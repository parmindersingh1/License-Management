class ProductLicensesController < ApplicationController
  require 'securerandom'
 
  # GET /product_licenses
  # GET /product_licenses.json
  def index
    @product_licenses = ProductLicense.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_licenses }
    end
  end

  # GET /product_licenses/1
  # GET /product_licenses/1.json
  def show
    @product_license = ProductLicense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_license }
    end
  end

  # GET /product_licenses/new
  # GET /product_licenses/new.json
  def new
    @product_license = ProductLicense.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_license }
    end
  end

  # GET /product_licenses/1/edit
  def edit
    @product_license = ProductLicense.find(params[:id])
  end

  # POST /product_licenses
  # POST /product_licenses.json
  def create
    @product_license = ProductLicense.new(params[:product_license])

    respond_to do |format|
      if @product_license.save
        format.html { redirect_to @product_license, notice: 'Product license was successfully created.' }
        format.json { render json: @product_license, status: :created, location: @product_license }
      else
        format.html { render action: "new" }
        format.json { render json: @product_license.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_licenses/1
  # PUT /product_licenses/1.json
  def update
    @product_license = ProductLicense.find(params[:id])

    respond_to do |format|
      if @product_license.update_attributes(params[:product_license])
        format.html { redirect_to @product_license, notice: 'Product license was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_license.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_licenses/1
  # DELETE /product_licenses/1.json
  def destroy
    @product_license = ProductLicense.find(params[:id])
    @product_license.destroy

    respond_to do |format|
      format.html { redirect_to product_licenses_url }
      format.json { head :no_content }
    end
  end

  def generate_keys
    puts "-------#{params[:keys_count]}"
    count=params[:keys_count]
    @error=false
    @generated_list=[]
    count.to_i.times do
      @list=SecureRandom.hex(8)
      @generated_list<<@list
      @key=ProductLicense.new(:license_key => @list)
      unless @key.save
        @error=true
      end
    end
    unless @error
      render :text=> "error"
    else
      render :text=> "created"
    end
  end

  def license_report
    @product_licenses=ProductLicense.all
    respond_to do |format|
      format.html
      format.rss
      format.xls {
        send_data(licenses_report(@product_licenses), :type=>"application/ms-excel", :filename => "report.xls",:orientation=>"landscape",:margin=>{:top=>0.25,:bottom=>0.25,:left=>0.25,:header=>0.05})
      }
    end
  end
end
