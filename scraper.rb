require 'Mechanize'
require 'dotenv/load'

#Scrape moodle and return a hash of completed courses and their associated grade
def scrape_grades
  agent = Mechanize.new
  agent.user_agent = "Grade Update Checker"
  login_page = agent.get("https://wrem.sis.yorku.ca/Apps/WebObjects/ydml.woa/wa/DirectAction/document?name=CourseListv1") 
  login_form = login_page.form("loginform")

  login_form.field_with(id: "mli").value = ENV.fetch("USERNAME")
  login_form.field_with(id: "password").value = ENV.fetch("PASSWORD")
  agent.submit(login_form, login_form.buttons.first)

  grade_page = agent.get("https://wrem.sis.yorku.ca/Apps/WebObjects/ydml.woa/wa/DirectAction/document?name=CourseListv1")
  raw_data = grade_page.css("table.bodytext td").map { |name| name.text}

  course_list = []
  grades_list = []

  raw_data.each_with_index do |value, index|
    if index % 4 == 2
      course_list << value
    elsif index % 4 == 3
      grades_list << value
    end
  end

  grades = Hash[course_list.zip(grades_list)]
  grades.reject!{ |key| grades[key].length > 2 }
end