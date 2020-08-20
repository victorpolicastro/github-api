# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string(:email, uniq: true)
      t.string(:password_digest)

      t.timestamps
    end

    add_index(:users, [:email], unique: true, name: 'index_users_email_uniqueness')
  end
end
