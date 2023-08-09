class Task < ApplicationRecord
    has_paper_trail
  
    validates :title, presence: true, length: { maximum: 100 }
    validates :completed, inclusion: { in: [true, false] }
    validates :priority, inclusion: { in: ['low', 'medium', 'high'] }
  end
  