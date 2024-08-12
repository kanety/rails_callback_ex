class CreateSamples < ActiveRecord::Migration::Current
  def change
    create_table :samples do |t|
      t.text       :title
    end
  end
end
