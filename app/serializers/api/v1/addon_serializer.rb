module Api
  module V1
    class AddonSerializer < ActiveModel::Serializer
    	attributes :id, :name, :description, :addon_type, :min, :max, :cart_item_id

    	has_many :cart_items
    end
  end
end
