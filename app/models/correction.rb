class Correction < ActiveRecord::Base
  belongs_to :sentence
  belongs_to :advisor, class_name: 'User'
  belongs_to :correction_log
end
