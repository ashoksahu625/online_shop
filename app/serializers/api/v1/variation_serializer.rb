module Api
  module V1
    class VariationSerializer < ActiveModel::Serializer
    	attributes :id, :name, :description, :variation_type, :cart_item_id, :has_addons

    	has_many :cart_items
    end
  end
end
