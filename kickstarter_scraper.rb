require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
 
  kickstarter = Nokogiri::HTML(html)

  projects = {}
 
  # Iterate through the projects
  kickstarter.css("li.project.grid_4").each do |project|
    projects[project] 
    
  #add title
  title = project.css("h2.bbcard_name strong a").text
  projects[title.to_sym] = {
  
  #add image link 
  :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
  
  #add description
  :description => project.css("p.bbcard_blurb").text,
  
  #add location
  :location => project.css("ul.project-meta span.location-name").text,
  
  #add percent_funded
  :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  
  # return the projects hash
  projects
  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link:project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
end

create_project_hash