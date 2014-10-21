class Report < ActiveRecord::Base
	validates :title, :content, presence: true
	
  belongs_to :author, class_name: 'User'
end