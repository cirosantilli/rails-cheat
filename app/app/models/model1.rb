class Model1 < ActiveRecord::Base
  has_many :model1
  validates :string_col, presence: true
end
