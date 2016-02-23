class AddIdeaToPictures < ActiveRecord::Migration
  def change
    add_reference :pictures, :idea, index: true, foreign_key: true
  end
end
