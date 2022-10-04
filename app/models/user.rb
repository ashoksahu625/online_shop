class User < ApplicationRecord
  
  validates_uniqueness_of :email
  validates_presence_of :email
  validates_presence_of :name
  has_one :cart  
end
