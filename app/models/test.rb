require './crawler'
require "benchmark"
  

 
  keywords = ['agency','services','mail','intl', 'STANDINGS', 'Carrer', 'Carrers', 'Inicio', 'Images', 'honda', 'These']
  c = Crawler.new('http://www.billfryer.com', keywords, 1)
  time = Benchmark.measure do
  	  c.crawl

  end
  puts c.isBusiness
  puts c.matched_keywords
puts time
