class Report < ActiveRecord::Base
  belongs_to :writer, class_name: 'User'
end
