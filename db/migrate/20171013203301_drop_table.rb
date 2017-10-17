# frozen_string_literal: true

class DropTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :status_comments
  end
end
