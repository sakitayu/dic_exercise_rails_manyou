class RemoveDefaultFromExpiredAt < ActiveRecord::Migration[5.2]
  def up
    change_column_default :tasks, :expired_at, nil
  end
end
