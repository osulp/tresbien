class AddUserToStatusComment < ActiveRecord::Migration[5.1]
  def change
    add_reference :status_comments, :user, foreign_key: true
  end
end
