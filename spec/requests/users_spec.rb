require 'spec_helper'

describe "Users" do
  subject { page }
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
    
    describe "with valid information" do
      # let(:user) {FactoryGirl.create(:user)}
      before do
        fill_in "user_email",    with: "example@demo.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        
      end
      it "should create a user" do
        expect { click_button submit}. to change(User, :count).by(1)
      end
      
    end
  end
  
  describe "index" do
    
      before do 
        sign_in FactoryGirl.create(:user)
        FactoryGirl.create(:user, email: "bob@example.com")
        FactoryGirl.create(:user, email: "ben@example.com")
        visit users_path
      end
      
      it { should have_content('All users') }
    # it "should list each user" do
      # User.all.each do |user|
        # expect(page).to have_selector('li')
      # end
    # end
  end
  
  
end
