class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :type
  has_one_attached :footage
end
