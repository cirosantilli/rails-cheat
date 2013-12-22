class Model1 < ActiveRecord::Base
  has_many :model0s
  validates :string_col, presence: true
end
