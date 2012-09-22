require './crawler'
  keywords = ['mail','intl']
  c = Crawler.new
  c.crawl('http://www.ewef.com/', keywords)