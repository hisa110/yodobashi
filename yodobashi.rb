#coding:utf-8

require 'nokogiri'
require 'open-uri'


# argument "マルチメディア川崎ルフロン"
shop_name = ARGV[0]
code = ARGV[1]

shop_name = "マルチメディア川崎ルフロン" if shop_name.nil?
code = "AQ" if code.nil?

yodo_url = "http://www.yodobashi.com"

### top page

doc = Nokogiri::HTML(open(yodo_url + '/ec/support/news/1213384796888/index.html'))
shop_link=nil
doc.search("/html/body/div[@id='Wrapper']/div[@id='frame']/div[@id='BodyContent']/table/tr/td[@id='MainArea']/div[@id='PageBodyArea']/div[@class='Box15B']/table/tr/td/ul[@class='List03B']/li/a").each do |str|
#/tr/

  if str.text == shop_name
  	shop_link   = str.get_attribute("href")
  end

end

### shop page
doc = Nokogiri::HTML(open(yodo_url + shop_link))

#doc.search("/html/body/div[@id='wrapper']/div[@id='frame']/div[@id='oldLayout']/div[@class='newsBody']").each do |str|
doc.search("//td").each do |str|

  # get only text node
  str.children.each do |paa|
    aaa = paa.text.gsub(/～/," ").gsub(/、/," ").split(" ").collect{|x| x.scan(/[A-Z]+/).join(",")}.find{|x| /^#{code}$/ =~ x } if paa.text?
    p "You'll get iPhone5! Please check it!. " + yodo_url + shop_link unless aaa.nil?
  end

end


