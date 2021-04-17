require 'open-uri'
require 'nokogiri'

def fetch_top_five
  # url from imdb
  url = 'https://www.imdb.com/chart/top'
  base_url = 'https://www.imdb.com'
  html = open(url, 'Accept-Language' => 'en').read
  doc = Nokogiri::HTML(html) # nokogiri objects

  doc.search(".titleColumn a").first(5).map do |element|
    # p element # nokogiri object
    base_url + element.attributes['href'].value
  end
end

def scrape_movie(url)
  html = open(url, 'Accept-Language' => 'en').read # html
  doc = Nokogiri::HTML(html) # nokogiri objects
  info = {}
  info[:storyline] = doc.search('.summary_text').text.strip
  info[:year] = doc.search('#titleYear a').text.strip.to_i
  info[:director] = doc.search('.credit_summary_item').first.search('a').text
  info[:title] = doc.search('h1').text.split('(').first.strip[0...-1]
  info[:cast] = doc.search('.credit_summary_item')[2].search('a').first(3).map do |actor|
    actor.text.strip
  end
  return info
  # p info
  # return a hash of all of the information
end

# scrape_movie('https://www.imdb.com/title/tt0468569/')
