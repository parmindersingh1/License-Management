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
    data[row_index,column_index+1]="calculated_key"
    data[row_index,column_index+2]="email"
    data[row_index,column_index+3]="machine id"
    data[row_index,column_index+4]="expiry_date"
    data[row_index,column_index+5]="reset counter"
    data[row_index,column_index+6]="allow regeneration"
    data[row_index,column_index+7]="is assigned"
    data[row_index,column_index+8]="is created"
    data[row_index,column_index+9]="is deleted"
    data[row_index,column_index+10]="created by"
    data[row_index,column_index+11]="updated by"
    data[row_index,column_index+12]="updated date"
    data[row_index,column_index+13]="created at"

    product_licenses.each_with_index do |lic,i|
      data[row_index+i+1,column_index]=lic.license_key
      data[row_index+i+1,column_index+1]=lic.calculated_key
      data[row_index+i+1,column_index+2]=lic.email
      data[row_index+i+1,column_index+3]=lic.machine_id
      data[row_index+i+1,column_index+4]=lic.expiry_date
      data[row_index+i+1,column_index+5]=lic.reset_counter
      data[row_index+i+1,column_index+6]=lic.allow_regeneration
      data[row_index+i+1,column_index+7]=lic.is_assigned
      data[row_index+i+1,column_index+8]=lic.is_created
      data[row_index+i+1,column_index+9]=lic.is_deleted
      data[row_index+i+1,column_index+10]=lic.created_by
      data[row_index+i+1,column_index+11]=lic.updated_by
      data[row_index+i+1,column_index+12]=lic.updated_date
      data[row_index+i+1,column_index+13]=lic.created_at
    end

    blob = StringIO.new('')
    book.write(blob)
    blob.rewind
    blob.read
  end
end
