class CreateDrinks < ActiveRecord::Migration[6.0]
  def change
    create_table :drinks do |t|
      t.string      :name                , null: false
      t.text        :description         , null: false
      t.integer     :alc_percent         , null: false
      t.text        :combo
      t.integer     :genre_id            , null: false
      t.integer     :sweet_dry_id        , null: false
      t.integer     :recommendation_id   , null: false
      t.integer     :best_time_id
      t.references  :user,                 null: false, foreign_key: true
      t.timestamps
    end
  end
end
