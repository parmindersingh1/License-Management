require 'spec_helper'

describe "Users" do
  describe "Home Page" do
    let(:user) { FactoryGirl.create(:user) }
    it "it should have the content 'Wecome to the License Management System'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/users/dashboard'
      expect(page).to have_content('Wecome to the License Management System')
      
    end
  end
  
  describe "Sign Up Page" do
    it "it should have the content 'Sign Up'" do
      visit signup_path
      expect(page).to have_content('Sign Up')
    end
  end
  describe "Sign Up page" do 
    before { visit signup_path }
    let(:submit) { "Sign Up" }
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
  end
  
  
end
