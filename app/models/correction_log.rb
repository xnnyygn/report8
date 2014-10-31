class CorrectionLog < ActiveRecord::Base
  belongs_to :report
  belongs_to :advisor
end
