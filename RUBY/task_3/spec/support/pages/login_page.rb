class LoginPage
    include Capybara::DSL
  
    def login(username, password)
      fill_in 'user-name', with: username
      fill_in 'password', with: password
      click_button 'login-button'
    end
end