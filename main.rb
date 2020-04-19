require_relative 'scraper'
require_relative 'email'

# Setup a variable to hold the results of the last scrape and delay properly
last_scrape = scrape_grades
sleep(1800)

# The main program loop
while true

  current_scrape = scrape_grades
  new_grades = current_scrape - last_scrape

  if difference.length != 0
    send_email(new_grades)
  end

  sleep(1800)
end