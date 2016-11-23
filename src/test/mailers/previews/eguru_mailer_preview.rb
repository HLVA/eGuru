# Preview all emails at http://localhost:3000/rails/mailers/eguru_mailer
class EguruMailerPreview < ActionMailer::Preview
	def sample_mail_preview
		user = '0912203@gmail.com'
	    EguruMailer.sample_email(user)
	  end
end
