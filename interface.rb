require_relative 'scraper'
require 'yaml'
# .each one of the pages, we'll open the link
# title, director, cast, year, storyline

urls = fetch_top_five

movie_infos = urls.map do |url|
  scrape_movie(url)
end

puts "Writing to yml file...."
File.open('movie.yml', 'w') do |f|
  f.write(movie_infos.to_yaml)
end
