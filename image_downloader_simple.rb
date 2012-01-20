
require 'net/http'
require 'uri'

uri = URI("http://xxxx.jpg")

Net::HTTP.start(uri.host, uri.port) do |http|
  req = Net::HTTP::Get.new(uri.request_uri)
  http.request(req) do |res|
    f_name = "file.jpg"
    puts "f_name"
    begin
      f = File.new(f_name, "w")
      f.binmode
      res.read_body do |data|
        f.write(data)
      end
    rescue
      puts "error\n"
    ensure
      f.close
    end
  end
end
