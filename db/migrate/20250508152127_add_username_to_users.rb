class AddUsernameToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string

    User.find_each do |user|
      user.update!(username: User.generate_username)
    end

    change_column_null :users, :username, false
  end
end
