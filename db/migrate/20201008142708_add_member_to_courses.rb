class AddMemberToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :total_member, :integer
  end
end
