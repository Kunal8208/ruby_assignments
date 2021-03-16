require 'uri'
require 'net/http'
require 'openssl'
require 'json'

def display_languages_list
  puts "------------------------ LANGUAGES ------------------------"
  $lang.each do |(k,v)|
    print "\n" if k.to_i % 5 == 0
    print "#{k}. #{v[1]}".ljust(30)
  end
end

def detect_and_translate(dest, string)
    translate_url = URI("https://google-translate1.p.rapidapi.com/language/translate/v2")
    detect_url = URI("https://google-translate1.p.rapidapi.com/language/translate/v2/detect")

    http = Net::HTTP.new(translate_url.host, translate_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(detect_url)
    request["content-type"] = 'application/x-www-form-urlencoded'
    request["accept-encoding"] = 'application/gzip'
    request["x-rapidapi-key"] = 'ecd2524fdfmshdd92d9e6db6a2edp147fdfjsnc6b34f3f97c7'
    request["x-rapidapi-host"] = 'google-translate1.p.rapidapi.com'
    
    request.body = "q="+string

    response = http.request(request)

    detected_language = JSON.parse(response.body)["data"]["detections"][0][0]["language"]
    puts "Entered text is in language #{detected_language}"

    request = Net::HTTP::Post.new(translate_url)
    request["content-type"] = 'application/x-www-form-urlencoded'
    request["accept-encoding"] = 'application/gzip'
    request["x-rapidapi-key"] = 'ecd2524fdfmshdd92d9e6db6a2edp147fdfjsnc6b34f3f97c7'
    request["x-rapidapi-host"] = 'google-translate1.p.rapidapi.com'
    request.body = "q="+string+"&source="+detected_language+"&target="+dest

    response = http.request(request)
    return JSON.parse(response.body)["data"]["translations"][0]["translatedText"]

end

$file=File.read('./languages.json')
$lang = JSON.parse($file)
flag = true

while (flag)
  begin
    puts "1. Translate from file \n2. Translate text"
    print "Enter choice: "
    case gets.chomp.to_i
    when 1
      print "Enter file name: "
      file_name=gets.chomp
      display_languages_list

      print "\n\t\tEnter language choice to convert in: "
      ch_d=gets.chomp.to_i
      if(ch_d.between?(0, $lang.keys.last.to_i))
        dest = $lang[ch_d.to_s][0]
      else
        rasie ArgumentError.new("Invalid choice")
      end

      file_data=File.read(file_name)

      translated_text = detect_and_translate(dest, file_data)
      puts "Translated text in #{$lang[ch_d.to_s][1]}: #{translated_text}"

    when 2
    print "Enter your text: "
    str = gets.chomp

    print "\t\tEnter language choice to convert in: "
    ch_d=gets.chomp.to_i
    if(ch_d.between?(0, $lang.keys.last.to_i))
      dest = $lang[ch_d.to_s][0]
    else
     rasie ArgumentError.new("Invalid choice")
    end

    translated_text = detect_and_translate(dest, str)
    puts "Translated text in #{$lang[ch_d.to_s][1]}: #{translated_text}"
    end
    
  rescue ArgumentError => e
    puts "#{e.message}, #{e.trace}"
  end

    print "Do you want to Translate more ? (Y/y for YES): "
    ch = gets.chomp.to_s
    if !(ch=="Y" || ch=="y")
      flag = false
    end
  
end
