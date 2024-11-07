# Sauce Demo Testing Project

Automated tests for https://www.saucedemo.com testing login functionality and shopping cart operations.

## Test Scenarios
1. Add two items to cart and verify cart badge
2. Verify locked_out_user and error_user login restrictions

**Note:** error_user test will fail because task requires this user cannot login, but in reality they can.

## Setup & Run
1. Prerequisites:
   - Ruby
   - Chrome browser
   - Bundler

2. Install:
```bash
bundle install
```

3. Run tests:
```bash
rspec                    # all tests
rspec spec/login_spec.rb  # specific test
```

## Users
```ruby
standard_user:    'standard_user'     / 'secret_sauce'
locked_out_user:  'locked_out_user'   / 'secret_sauce'
error_user:       'error_user'        / 'secret_sauce'
```

Failed test screenshots will be saved in `screenshots` directory.

For questions or issues, please create an issue in the repository.