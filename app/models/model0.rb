# It is not necessary to specify the fields and their types inside this class:
# this is only specified once at the migrations.
#
# This class only condtains extra actions to take on those fields,
# for example validation.
class Model0 < ActiveRecord::Base

  ##associations

      belongs_to :model1
      has_one    :model2, through: :model1
      has_one    :model3, through: :model2
      #belongs_to :custom, class: Model1

  # Change the name of the table.
  # Default: lowercase underlined class name.
  # If this is changed it is also necessary to change the text fixture names.
  # under `test/fixtures`.

    #self.table_name = "PRODUCT"

      #validates :string_col,
        #presence: true,
        #uniqueness: {message: "custom message: must be unique"},
        #length: {minimum: 2, maximum:4, message: "custom message: length must be between 2 and 4" },
        #format: {with: /a.*/, message: "custom message: must start with the letter a"}
        #format: /a.*/

      validates :integer_col,
        numericality: true
        #inclusion: 1..10
        #numericality: { greater_than: 0, less_than_or_equal_to: :another_field }

      #validates_associated :model1
      #validates :terms_of_service, acceptance: true
end
