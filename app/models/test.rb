require './crawler'
  keywords = ['services','thegame']
  c = Crawler.new('http://www.google.com/', keywords, 5)
  c.crawl
  puts c.isBusiness
