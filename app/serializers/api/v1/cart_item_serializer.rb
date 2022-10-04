module Api
  module V1
    class CartItemSerializer < ActiveModel::Serializer
      attributes :id, :name, :item_type, :item_attribute, :item_price, :base_price, :total_price, :is_out_of_stock, :is_item_available, :pos_category_name, :sub_category_name, :item_type, :display_price, :addon_id, :addon_group_name, :variations, :addons

      def variations
        ActiveModelSerializers::SerializableResource.new(object.variations, each_serializer: Api::V1::VariationSerializer) if object&.variations.present?
      end

      def addons
        ActiveModelSerializers::SerializableResource.new(object.addons, each_serializer: Api::V1::AddonSerializer) if object&.addons.present?
      end
    end
  end
end
