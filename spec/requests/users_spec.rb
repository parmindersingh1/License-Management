require 'spec_helper'

describe "Users" do
  describe "Home Page" do
    it "it should have the content 'Welcome to the License Mananement System" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/users/show'
      expect(page).to have_content('Welcome to the License Mananement System')
      
    end
  end
end
