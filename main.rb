require_relative 'scraper'
require_relative 'email'

# Setup a variable to hold the results of the last scrape
last_scrape = scrape_grades
sleep(1800)

# The main program loop
while true
  begin 
    current_scrape = scrape_grades
  rescue
    send_error_email
    next
  end

  new_grades = current_scrape - last_scrape

  if new_grades.length != 0
    new_grades.each do |grade|
      send_email(grade)
    end
  end
  last_scrape = current_scrape
  sleep(1800)
end