require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should reject blank title or content" do
  	report = Report.new
  	assert report.invalid?
  	assert report.errors[:title].any?
  	assert report.errors[:content].any?
  end
  	
end
