#!/opt/local/bin/ruby

require 'open-uri'

Dir.chdir("test")

base_url = "http://api.search.yahoo.co.jp/ImageSearchService/V1/imageSearch"
id = "input yahoo id"
query = "query word"
results = "50"
adult = "1"

query_url  = base_url + 
	"?appid=" + id +
	"&query=" + query
	"&results=" + results

TagRegexp = /<.*?>/
UrlRegexp = /<Url>.*?<\/Url>/
i = 0

open(query_url) { |f|
  f.each_line { |line|
    line.scan(UrlRegexp) { |match|
      p match
      match = match.sub("<Url>", "")
      match = match.sub("</Url>", "")
      p match
      if match =~ /\.jpg$/
        begin
          f_name = "file"+ i.to_s + ".jpg"
          f = File.new(f_name, "w")
          f.binmode
          open(match) { |img|
            f.write(img.read)
          }
          puts "success\n"
        rescue
          puts "error\n"
        ensure
          f.close
          i += 1
        end
      end
    }
  }
}
