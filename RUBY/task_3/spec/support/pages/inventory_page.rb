class InventoryPage
    include Capybara::DSL
  
    def add_item_to_cart(item_id)
      click_on "add-to-cart-#{item_id}"
    end
  
    def cart_badge_count
      find('[data-test="shopping-cart-badge"]').text.to_i
    end 
end