class DevisePasswordlessAddTo<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def up
    change_table :<%= table_name %> do |t|
      t.string     :passwordless_token
      t.datetime   :passwordless_token_expired_at
      t.index      :passwordless_token, unique: true # for passwordless
    end
  end

  def down
    change_table :<%= table_name %> do |t|
      t.remove :passwordless_token, :passwordless_token_expired_at
    end
  end
end
