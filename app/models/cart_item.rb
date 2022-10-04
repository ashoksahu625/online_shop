class CartItem < ApplicationRecord

	has_many :variations, :foreign_key => "cart_item_id", dependent: :destroy
	has_many :addons, :foreign_key => "cart_item_id", dependent: :destroy

	def update_total_price
		price = [self.item_price]
		if self.variations.present?
			price = [0.0]
			price << self.variations.map{|row| row.get_price}.compact.inject(:+)
		end	
		if self.addons.present?
			price << self.addons.map{|row| row.get_price}.compact.inject(:+)
		end
		self.base_price = price.compact.inject(:+)
		self.total_price = self.base_price*quantity
		self.save
	end

end
