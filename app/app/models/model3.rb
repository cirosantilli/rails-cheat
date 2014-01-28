class Model3 < ActiveRecord::Base
  has_many :model2s
  has_many :model0s, through: :model2s
end
