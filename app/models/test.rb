require './crawler'
  keywords = ['mail','intl']
  c = Crawler.new('http://www.google.com.do/', keywords)
  c.crawl
  c.isBusiness