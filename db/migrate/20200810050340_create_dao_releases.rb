# typed: false
class CreateDaoReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :dao_releases, id: :uuid do |t|
      t.references :dao_product, type: :uuid, foreign_key: true, index: true
      t.string :title, null: false
      t.boolean :can_remove, null: false

      t.timestamps
    end
  end
end
