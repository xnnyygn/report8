class Department < ActiveRecord::Base
  has_one :creator, class_name: 'User'
end