class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.datetime :created_at, index: true, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :action, index: true
    end
  end
end
