class GeneralController < ApplicationController
  def aboutus
  end

  def send_mail
  	user = '0912203@gmail.com'
	EguruMailer.sample_email(user).deliver
  end
end
