class UserMailer < ActionMailer::Base
  def registration_confirmation(user,subject,body)
    # recipients  user.email
    # from        "office@ezzie.in"
     # subject     subject
     # body        body
    #mail(:from=>"saini.pardeep8@gmail.com",:to => "pardeep@ezzie.in",:subject=>"Password reset")
    @user = user
    @url = "http://gmail.com"
    mail( from: "testing.testing055@gmail.com", to: user.email, subject:"Password Reset",body: body)
  end

end
