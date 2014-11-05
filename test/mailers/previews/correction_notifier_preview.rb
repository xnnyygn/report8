# Preview all emails at http://localhost:3000/rails/mailers/correction_notifier
class CorrectionNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/correction_notifier/received
  def received
    CorrectionNotifier.received
  end

end
