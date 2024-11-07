require 'spec_helper'

RSpec.describe 'Login Tests' do
  UserRoles::USERS.each do |user_type, user_data|
    context "with #{user_type}" do
      it "attempts login" do
        visit '/'
        fill_in 'user-name', with: user_data[:username], visible: true
        fill_in 'password', with: user_data[:password], visible: true
        click_button 'login-button'

        case user_type
        when :standard_user
          expect(page).to have_css('.app_logo')
        when :locked_user
          expect(page).to have_content('Epic sadface: Sorry, this user has been locked out')
        when :error_user
            expect(page).to('')
        else
            expect(page).to have_content('Epic sadface: An error occurred')
        end
      end
    end
  end
end