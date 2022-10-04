module Api
  module V1
    class CartSerializer < ActiveModel::Serializer
    	attributes :id, :user_id, :gross_amount, :cart_items

    	def cart_items
	        ActiveModelSerializers::SerializableResource.new(object.cart_items, each_serializer: Api::V1::CartItemSerializer) if object&.cart_items.present?
	    end
    end
  end
end
