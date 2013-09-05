module ProductLicensesHelper
  def licenses_report(product_licenses)
    puts "-----------------#{product_licenses}"
    book = Spreadsheet::Workbook.new
    default_format = Spreadsheet::Format.new :color => :black, :size => 8,:horizontal_align=> :center
    book.default_format = default_format
    data = book.create_worksheet :name =>"product licenses"
    bold = Spreadsheet::Format.new :weight => :bold,:horizontal_align=> :center
    header = Spreadsheet::Format.new :weight => :bold
    index=0
    data.row(index).default_format=bold
    alignment = Spreadsheet::Format.new :align => :merge,:size=>8,:horizontal_align=> :center

    data.merge_cells(0,0,0,13)
    row_index=2
    column_index=0
    data[0,0]="Product Licenses"
    data.row(row_index).default_format=bold
    14.times do |n|
      data.column(n).width = 20
    end
    data[row_index,column_index]= "License key"
    data[row_index,column_index+1]= "Voices"
    data[row_index,column_index+2]="calculated_key"
    data[row_index,column_index+3]="email"
    data[row_index,column_index+4]="machine id"
    data[row_index,column_index+5]="expiry_date"
    data[row_index,column_index+6]="reset counter"
    data[row_index,column_index+7]="allow regeneration"
    data[row_index,column_index+8]="is assigned"
    data[row_index,column_index+9]="is created"
    data[row_index,column_index+10]="is deleted"
    data[row_index,column_index+11]="created by"
    data[row_index,column_index+12]="updated by"
    data[row_index,column_index+13]="updated date"
    data[row_index,column_index+14]="created at"

    product_licenses.each_with_index do |lic,i|
      data[row_index+i+1,column_index]=lic.license_key
      all_products = ""
      lic.products.each do |product|
        all_products= product.name.to_s+","+all_products
      end 
      data[row_index+i+1,column_index+1]=all_products
      data[row_index+i+1,column_index+2]=lic.calculated_key
      data[row_index+i+1,column_index+3]=lic.email
      data[row_index+i+1,column_index+4]=lic.machine_id
      data[row_index+i+1,column_index+5]=lic.expiry_date
      data[row_index+i+1,column_index+6]=lic.reset_counter
      if lic.allow_regeneration?
        data[row_index+i+1,column_index+7]="Yes"
      else
        data[row_index+i+1,column_index+7]="No"
      end
      if lic.is_assigned?
        data[row_index+i+1,column_index+8]="Yes"
      else
        data[row_index+i+1,column_index+8]="No"
      end
      if lic.is_created?
        data[row_index+i+1,column_index+9]="Yes"
      else
        data[row_index+i+1,column_index+9]="No"
      end
      if lic.is_deleted?
        data[row_index+i+1,column_index+10]="Yes"
      else
        data[row_index+i+1,column_index+10]="No"
      end
      data[row_index+i+1,column_index+11]=lic.created_by
      data[row_index+i+1,column_index+12]=lic.updated_by
      data[row_index+i+1,column_index+13]=lic.updated_date
      data[row_index+i+1,column_index+14]=lic.created_at
    end

    blob = StringIO.new('')
    book.write(blob)
    blob.rewind
    blob.read
  end
end
