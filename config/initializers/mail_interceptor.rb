# Catch emails on staging and dev to avoid sending real emails.
if Rails.env.staging? || Rails.env.development?
  module Propertea
    class MailInterceptor
      def self.delivering_email(email)
        email.subject = "#{email.to} #{email.subject}"
        email.to = 'test@propertea.io'
      end
    end
  end

  ActionMailer::Base.register_interceptor(Propertea::MailInterceptor)
end
