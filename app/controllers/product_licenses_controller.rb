class ProductLicensesController < ApplicationController
  require 'securerandom'
  require 'openssl'
  require 'base64'
  #before_filter :signed_in_user ,:except=> [:generate_license_key]
  # GET /product_licenses
  # GET /product_licenses.json
  def index
    #@products = Product.find(:all);
    

    @product_licenses = ProductLicense.find(:all)
    check_result=system("Debug/Registrybackup.exe")
    puts check_result
     
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
    puts "-------#{params}"
    count=params[:keys_count]
    product_list = params[:product_list]
    @error=true
    count.to_i.times do
      @list=SecureRandom.hex(3)
      @key=ProductLicense.new()
      @key.license_key = @list
      # @key.product_id = params[:product_id]
      if @key.save
        if (product_list.kind_of?(Array))
          product_list.each do |prod|
            product_object=Product.find_by_id(prod)
            @key.products<<product_object
          end
        end
        @error=false
      end
    end
  
    if @error
      render :json=> {:valid=>false, :notice=>"Error in key Generation"}
    else
      render :json=> {:valid=>true, :notice=>"Key Successfully generated"}
    end
  end

  def license_report
    puts "--++++++++--------#{params}"
    @product_licenses=ProductLicense.where(:product_id=>params[:product_id])
    respond_to do |format|
      format.html
      format.rss
      format.xls {
        send_data(licenses_report(@product_licenses), :type=>"application/ms-excel", :filename => "report.xls",:orientation=>"landscape",:margin=>{:top=>0.25,:bottom=>0.25,:left=>0.25,:header=>0.05})
      }
    end
  end
  
  def date_range_license_report
    puts "----------#{params}"
    @selected_date1=params[:start_date].to_date
    @selected_date2=params[:end_date].to_date
    puts "#{@selected_date1 } ----------------#{@selected_date2 }"
    @product_licenses=ProductLicense.where(:created_at => @selected_date1.beginning_of_day..@selected_date2.end_of_day)
    respond_to do |format|
      format.html
      format.rss
      format.xls {
        send_data(licenses_report(@product_licenses), :type=>"application/ms-excel", :filename => "report.xls",:orientation=>"landscape",:margin=>{:top=>0.25,:bottom=>0.25,:left=>0.25,:header=>0.05})
      }
    end
  end
  
def generate_license_key
    puts "params are #{params}"

   
    
    @received_key = params[:data][:license_key]
    @machine_id = params[:data][:machine_id]
    @email = params[:data][:email]
    

   
    license_key = ProductLicense.find_by_license_key(@received_key)
        
    unless license_key.nil?
      if license_key.is_assigned
        render :json=> {:valid=>false , :message=> "Key already generated for this license key"}
      else
        @voices=""
        
        license_key.products.each do |voice|
          unless voice.name.nil?
            if @voices==""
              @voices=voice.name.to_s            
            else
            @voices=@voices+","+voice.name.to_s
            end
          end 
        end

        # our code

        @name="manish"
         @string = @machine_id+"|"+@received_key+"|"+@email+"|"+@voices+"|"+@name
      @generated_key = Digest::MD5.hexdigest(@string)
      signature= @generated_key
   
       

        license_key.update_attributes(:calculated_key=>@generated_key,:email=>@email,:machine_id=>@machine_id,:is_assigned=>true,:is_created=>true,:is_deleted=>false)
        render :json=> {:valid=>true ,:digital_signature =>signature, :voices=>@voices,:message=>"key generated key successfully"}
      end
    else
      
      render :json=> {:valid=>false , :message=> "Key not generated for this license"}
    end 
  end
  
  def regeneration_report
    puts "--++++++++--------#{params}"
    @product_licenses=ProductLicense.where(:allow_regeneration=>true)
    respond_to do |format|
      format.html
      format.rss
      format.xls {
        send_data(licenses_report(@product_licenses), :type=>"application/ms-excel", :filename => "report.xls",:orientation=>"landscape",:margin=>{:top=>0.25,:bottom=>0.25,:left=>0.25,:header=>0.05})
      }
    end
  end
  
   def unassigned_report
    puts "--++++++++--------#{params}"
    @product_licenses=ProductLicense.where(:is_assigned=> false)
    respond_to do |format|
      format.html
      format.rss
      format.xls {
        send_data(licenses_report(@product_licenses), :type=>"application/ms-excel", :filename => "report.xls",:orientation=>"landscape",:margin=>{:top=>0.25,:bottom=>0.25,:left=>0.25,:header=>0.05})
      }
    end
  end
  
   def deleted_report
    puts "--++++++++--------#{params}"
    @product_licenses=ProductLicense.where(:is_deleted=> true)
    respond_to do |format|
      format.html
      format.rss
      format.xls {
        send_data(licenses_report(@product_licenses), :type=>"application/ms-excel", :filename => "report.xls",:orientation=>"landscape",:margin=>{:top=>0.25,:bottom=>0.25,:left=>0.25,:header=>0.05})
      }
    end
  end
  
  def show_licenses
    @product_licenses = ProductLicense.all
    # @product_licenses=ProductLicense.paginate(:page => 10, :conditions => "product_id = #{params[:product_id]}")
    # @product_licenses=ProductLicense.where(:product_id => params[:product_id]).paginate(:page => params[:page], :per_page => 10)
    render :partial => "license_partial"
  end
  
  def product_license_report
    @selected_date1=params[:start_date][:field].to_date
    @selected_date2=params[:end_date][:field].to_date
    puts "#{@selected_date1 } ----------------#{@selected_date2 }"
    @product_licenses=ProductLicense.where(:created_at => @selected_date1.beginning_of_day..@selected_date2.end_of_day)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_licenses }
    end
  end
  def regeneration_report_html
    @product_licenses=ProductLicense.where(:allow_regeneration=>true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_licenses }
    end
  end
  def product_license_report_html
    puts "the params are #{params}"
    @product_id = params[:product_license][:name]
    @product_licenses=ProductLicense.where(:product_id=>params[:product_license][:name])
     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_licenses }
    end
  end
  
  def unassigned_report_html
    @product_licenses=ProductLicense.where(:is_assigned=> false)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_licenses }
    end
  end
  
  def deleted_key_report_html
   @product_licenses=ProductLicense.where(:is_deleted=> true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_licenses }
    end
  end
  
  def delete_keys
    puts "the params are #{params}"
    unless params[:keys].nil?
      params[:keys].each do |key|
        license_key = ProductLicense.find_by_id(key)
        license_key.destroy
      end
    end
    render :text =>  "Keys Deleted Successfully"
  end
  
  
end
