class CreateCollaborationRecords < ActiveRecord::Migration
  def up
    Wiki.all.each do |wiki|
      Collaboration.create!(user: wiki.owner, wiki: wiki)
    end
  end
end
