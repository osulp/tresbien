# frozen_string_literal: true

class DropTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :status_comments
    remove_reference(:status_comments, :user, foreign_key: true)
  end
end
