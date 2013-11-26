class CreateUploadTotals < ActiveRecord::Migration
  def change
    create_table :upload_totals do |t|
      t.integer :upload_total
    end
    UploadTotal.create id: 1, upload_total: 0
  end
end
