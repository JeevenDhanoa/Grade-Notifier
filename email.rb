require 'dotenv/load'
require 'net/smtp'

def send_email(new_grade)
  sender_email = ENV.fetch('SENDER_EMAIL')
  sender_email_password = ENV.fetch('SENDER_EMAIL_PASSWORD')
  new_class = new_grade[0].to_s
  letter_grade = new_grade[1]

  message = 
  "From: Yourself Lol <#{sender_email}>
  \nTo: Yourself Lol <#{sender_email}>
  \nSubject: New Grade for #{new_class}
  \nMIME-Version: 1.0
  \nContent-type: text/html

  \n<head>
    <style type = text/css>
      p { color:#500050;}
    </style>
    </head>

  \nWhat up what up!! Your grade in #{new_class} is <b> #{letter_grade}</b>! Congrats!
  <br><br><hr>
  \n<p>
    This email was genereated automatically. View the source code for this project at https://github.com/JeevenDhanoa/Grade-Notifier. 
  </p>"

  smtp = Net::SMTP.new('smtp.gmail.com', 587)
  smtp.enable_starttls
  smtp.start('smtp.gmail.com', sender_email, sender_email_password, :login) do
    smtp.send_message(message, sender_email, sender_email)
  end
end