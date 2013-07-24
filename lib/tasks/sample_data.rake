namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(email: "office@ezzie.in",
                         password: "P@ssw0rd",
                         password_confirmation: "P@ssw0rd",
                         admin: true)
   end
end
