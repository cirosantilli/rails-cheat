# The goal of this class is to test has many with Model0
# through Model1, without having an exlicit through here.
class Model22 < ActiveRecord::Base
  has_many :model1s
end
