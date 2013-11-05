# It is not necessary to specify the fields and their types inside this class:
# this is only specified once at the migrations.
#
# This class only condtains extra actions to take on those fields,
# for example validation.
class Model0 < ActiveRecord::Base

  ##associations

    # <http://guides.rubyonrails.org/association_basics.html>

    # All possible associations:
    #
    # - has_one. One to one relations. The other side has a belongs_to.
    # - belongs_to: One to many on the one side. The other side usually has `has_many`.
    # - has_many. One to many on the many side. The other side usually has a `belongs_to`
    # - has_many :through. Typical many to many.
    # - has_one :through
    # - has_and_belongs_to_many

      belongs_to :model1 #has a single model1
      #has_many :model1  #has many model1

  # Change the name of the table.
  # Default: lowercase underlined class name.
  # If this is changed it is also necessary to change the text fixture names.
  # under `test/fixtures`.

    #self.table_name = "PRODUCT"

  ##validates

    # Determines form validation constraints. Those will not affect the database,
    # but will make object creation fail if the fields do not pass the validations.

    ##error messages

      # If an message is given, the `true` is implicit.

      # If not, a standard error message exists for each error.

    # - presence: if true, field must be present (NOT NULL)
    # - length: minimum, maximum string length

      validates :string_col,
        presence: true,
        uniqueness: {message: "custom message: must be unique"},
        length: {minimum: 2, maximum:4, message: "custom message: length must be between 2 and 4" },
        format: {with: /a.*/, message: "custom message: must start with the letter a"}
        #format: /a.*/

      validates :integer_col,
        numericality: true

      #validates_associated :model1

    # A checkbox that must be checked to continue:

      #validates :terms_of_service, acceptance: true
end
