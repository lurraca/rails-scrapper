require './crawler'
require "benchmark"
  

 
  keywords = ['services','mail','intl']
  c = Crawler.new('http://www.google.com/', keywords, 1)
  time = Benchmark.measure do
  	  c.crawl

  end
  puts c.isBusiness
  puts c.matched_keywords
puts time