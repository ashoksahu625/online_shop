module Api
  module V1
  	class CartItemsController < ApplicationController
  		before_action :find_user

  		def get_manu_items
        @cart = @user.cart
        if @cart.present?
          render :json => ActiveModel::SerializableResource.new(@cart, serializer: Api::V1::CartSerializer).serializable_hash,
            :status => :ok
        else
          render :json => {:message => "Record not found"},
            :status => :ok
        end
      end

      def create
        @cart = Cart.find_or_create_by(user_id: @user.id)
        @cart_item = CartItem.new(cart_item_params(params))
        @cart_item.cart_id = @cart.id
        @cart_item.save
        if params[:variations].present?
          params[:variations].each do |variation|
            @variation = Variation.new(variation_params(variation))
            @variation.cart_item_id = @cart_item.id
            @variation.save
            if variation[:items].present?
              variation[:items].each do |item|
                cart_item = CartItem.new(cart_item_params(item))
                cart_item.parent_item_id = @cart_item.id
                cart_item.variation_id = @variation.id
                cart_item.save
              end  
            end
          end
        end
        if params[:addons].present?
          params[:addons].each do |addon|
            @addon = Addon.new(addon_params(addon))
            @addon.cart_item_id = @cart_item.id
            @addon.save
            if addon[:items].present?
              addon[:items].each do |item|
                cart_item = CartItem.new(cart_item_params(item))
                cart_item.addon_id = @addon.id
                cart_item.save
              end  
            end 
          end   
        end
        @cart.update_gross_amount
        render :json => ActiveModel::SerializableResource.new(@cart, serializer: Api::V1::CartSerializer).serializable_hash,
            :status => :ok 
      end

      def update_cart_items
        @cart = Cart.find_or_create_by(user_id: @user.id)
        @cart_item = @user.cart.cart_items.find_by_id(params[:cart_item_id])
        if @cart_item.present? && params[:quantity].to_i > 0
          @cart_item.update(quantity: params[:quantity])
          if params[:variations].present?
            variation_ids = params[:variations].map{ |row| row[:variation_id] if row[:variation_id].present?}.compact
            @cart_item.variations.where.not(id: variation_ids).destroy_all
            params[:variations].each do |variation|
              @variation = @cart_item.variations.find_by_id(variation[:variation_id])
              if variation[:items].present? && @variation.present?
                item_ids = variation[:items].map{ |row| row[:cart_item_id] if row[:cart_item_id].present?}.compact
                @variation.cart_items.where.not(id: item_ids).destroy_all
              end 
            end   
          end
          if params[:addons].present?
            addon_ids = params[:addons].map{ |row| row[:addon_id] if row[:addon_id].present?}.compact
            @cart_item.addons.where.not(id: addon_ids).destroy_all
            params[:addons].each do |addon|
              @addon = @cart_item.addons.find_by_id(addon[:addon_id])
              if addon[:items].present? && @addon.present?
                item_ids = addon[:items].map{ |row| row[:cart_item_id] if row[:cart_item_id].present?}.compact
                @addon.cart_items.where.not(id: item_ids).destroy_all
              end
            end  
          end
          @cart_item.cart
          render :json => ActiveModel::SerializableResource.new(@cart, serializer: Api::V1::CartSerializer).serializable_hash,
            :status => :ok 
        else
          @cart_item = @user.cart.cart_items.find_by_id(params[:cart_item_id])
          @cart_item.destroy
          @cart.update_gross_amount
          render :json => ActiveModel::SerializableResource.new(@cart, serializer: Api::V1::CartSerializer).serializable_hash,
            :status => :ok 
        end  
        
      end

  		private

      def cart_item_params(data)
  			data.permit(:name, :description, :quantity, :pos_item_id, :item_attribute, :pos_category_id, :pos_category_name, :item_price, :sub_category_name, :is_out_of_stock, :is_item_available, :cart_id, :item_type, :parent_item_id, :display_price, :variation_id, :addon_group_id, :addon_group_name)
  		end

      def variation_params(variation)
        variation.permit(:name, :description, :variation_type, :has_addons, :cart_item_id)
      end

      def addon_params(addon)
        addon.permit(:name, :description, :addon_type, :cart_item_id, :min, :max)
      end

  		def find_user
  			@user = User.find_by_id(params[:user_id])
        return render :json => {:message => "User not found"}, :status => :ok unless @user.present?
  		end
  	end
  end
end