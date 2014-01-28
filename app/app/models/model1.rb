class Model1 < ActiveRecord::Base
  has_many :model0s
  belongs_to :model2
  belongs_to :model22
end
