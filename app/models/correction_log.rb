class CorrectionLog < ActiveRecord::Base
  belongs_to :report
  belongs_to :advisor, class_name: 'User'
  has_many :corrections
end
