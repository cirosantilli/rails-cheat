class Model2 < ActiveRecord::Base
  belongs_to :model3
  has_many :model1s
  has_many :model0s, through: :model1s
end
