class UploadTotal < ActiveRecord::Base
    validates :upload_total,
      numericality: { greater_than_or_equal_to: 0 }
end
