module LoginHelper
    def login_as(user_type)
        user = UserRoles::USERS[user_type]
        fill_in 'user-name', with: user[:username], visible: true
        fill_in 'password', with: user[:password], visible: true
        click_button 'login-button'
        expect(page).to have_css('.app_logo') 
    end

    def logout
        find('#react-burger-menu-btn').click
        find('#logout_sidebar_link').click
    end
end
  