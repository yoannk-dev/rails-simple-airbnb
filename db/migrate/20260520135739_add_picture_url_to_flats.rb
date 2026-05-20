class AddPictureUrlToFlats < ActiveRecord::Migration[8.1]
  def change
    add_column :flats, :picture_url, :string
  end
end
