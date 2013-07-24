class UserMailer < ActionMailer::Base
  def registration_confirmation(user,subject,body)
    # recipients  user.email
    # from        "office@ezzie.in"
    # subject     subject
    # body        body
    #mail(:from=>"saini.pardeep8@gmail.com",:to => "pardeep@ezzie.in",:subject=>"Password reset")
    @user = user
    @url = "http://gmail.com"
    mail( from: "office.ezzie.com", to: "saini.pardeep87@gmail.com", subject: "Welcome to My Awesome Site",body: body)
  end

end
