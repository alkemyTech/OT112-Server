class ContactNotifierMailer < ApplicationMailer
  default from: ENV['DEFAULT_FROM_EMAIL_ADDRESS']

  def send_contact_email(contact)
    puts "enviando mail"
    @contact = contact
    mail(to: @contact.email,
      subject: "Usted se ha contactado correctamente.")
  end
end
