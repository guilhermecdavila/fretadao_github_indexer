class CreateGithubUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :github_users do |t|
      t.string :name, index: true
      t.string :github_url, index: true
      t.string :nickname, index: true
      t.string :image_url
      t.string :contribution
      t.string :followers
      t.string :following
      t.string :stars
      t.string :organization, index: true
      t.string :location, index: true
      t.string :encripted_github_url

      t.timestamps
    end
  end
end
