RSpec.describe 'Shopping Cart Tests' do
    context "with standard user" do
      before(:each) do
        visit '/'
        login_as(:standard_user)
      end
  
      it "can add item to cart" do
        click_on 'add-to-cart-sauce-labs-bike-light'
        cart_badge = find('[data-test="shopping-cart-badge"]')
        expect(cart_badge.text).to eq('1')

        click_on 'add-to-cart-sauce-labs-bolt-t-shirt'
        cart_badge = find('[data-test="shopping-cart-badge"]')
        expect(cart_badge.text).to eq('2')

      end
    end
end