require 'spec_helper'

describe "AuthenticationPages" do
    before { visit signin_path }
      subject { page }
      describe "signin page" do
      
      
      it { should have_content ('Please Sign in') }
    end
    
    describe "with invalid information" do
      before { click_button "Sign In" }

      it { should have_content('Please Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid email/password combination') }
                 
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
     
      before do
        
        fill_in "session_email",    with: user.email
        fill_in "session_password", with: user.password
        click_button "Sign In"
      end
      it { should have_content('Wecome to the License Management System')}
      it { should have_link("Home",   href: "/users/dashboard")}
      it { should have_link("Products",  href: "#")}
      it { should have_link("Reports",  href: "#")}
      it { should have_link(user.email, href: "#")}
      
      
      
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_content('Please Sign in') }
      end
     end
       
end
