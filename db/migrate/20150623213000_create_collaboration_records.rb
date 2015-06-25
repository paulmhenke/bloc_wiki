class CreateCollaborationRecords < ActiveRecord::Migration
  def up
    Wiki.all.each do |wiki|
      Collaboration.create!(user: wiki.owner, wiki: wiki)
    end
  end
end
 #? what is the point of this if db:reset undoes this, and we aren't dealing with any preexisting collaborations?