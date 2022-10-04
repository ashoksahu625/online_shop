class Addon < ApplicationRecord

	has_many :cart_items, :foreign_key => "addon_id", dependent: :destroy
	
	def get_price
		self.cart_items.map{|row| row.item_price}.compact.inject(:+)
	end
end
