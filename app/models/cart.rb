class Cart < ApplicationRecord

	has_many :cart_items, dependent: :destroy

	def update_gross_amount
		self.cart_items.map{|row| row.update_total_price}
		gross_amount = self.cart_items.map{|row| row.total_price}.compact.inject(:+)
		self.gross_amount = gross_amount
		self.save
	end
end