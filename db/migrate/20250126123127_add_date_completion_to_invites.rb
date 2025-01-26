class AddDateCompletionToInvites < ActiveRecord::Migration[7.1]
  def change
    add_column :invites, :date_completion, :date
  end
end
