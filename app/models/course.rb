class Course < ApplicationRecord
  
  has_rich_text :description

  enum status: { open: 0, ongoing: 1, finished: 2 }

  scope :recent_courses, ->{order created_at: :desc}

  after_initialize do
    self.status ||= :open if self.new_record?
  end

  validates :name, presence: true,
    length: {maximum: Settings.validate.course_name.max_length},
    uniqueness: true
end
