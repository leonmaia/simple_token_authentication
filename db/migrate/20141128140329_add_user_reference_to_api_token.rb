class AddUserReferenceToApiToken < ActiveRecord::Migration
  def change
    add_reference :api_tokens, :user, index: true
  end
end
