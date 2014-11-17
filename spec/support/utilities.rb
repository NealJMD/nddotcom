def support_file(filename)
  return File.new(Rails.root + 'spec/support/'+filename)
end

def create_admin
  a = Admin.new(email: "nealjmd@gmail.com", password: "asdfasdf")
  a.save!
  return a
end

def login_as(admin)
  visit new_admin_session_path
  fill_in "Email", with: admin.email
  fill_in "Password", with: admin.password
  click_button "Log in"
end

def log_out
  click_link "Log out"
end