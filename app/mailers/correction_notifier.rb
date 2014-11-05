class CorrectionNotifier < ActionMailer::Base
  default from: "noreply@report8.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.correction_notifier.received.subject
  #
  def received(author, advisor, report)
    @advisor = advisor
    @report = report

    mail to: author.email, subject: 'You got new corrections'
  end
end
