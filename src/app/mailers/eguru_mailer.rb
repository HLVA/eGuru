class EguruMailer < ApplicationMailer
	default from: "from@example.com"

  def sample_email(user)
    @user = user
    mail(to: @user, subject: 'Sample Email')
  end
end
