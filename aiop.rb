require 'twitter'
#require 'dotenv'

class TwitterClient

  attr_accessor :data, :results

  def initialize
    #Dotenv.load
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
    end
  end

  def search(distance=".25", lat="40.73721700000001", lon="-73.99556310000003")
    @results = @client.search('-rt', result_type: "recent", geocode: "#{lat.to_s},#{lon.to_s},#{distance.to_s}km")
    @data = []
    @results.attrs[:statuses].each do |status|
      time = Time.parse(status[:created_at])
      @data << {time: time.strftime('%l:%M%P'),
               user: status[:user][:screen_name], 
               name: status[:user][:name], 
               name_q: status[:user][:name].gsub(' ','+'), 
               description: status[:user][:description], 
               text: status[:text], 
               location: { lat: status[:geo][:coordinates][0] , lon:status[:geo][:coordinates][1] },
               #blurb: "#{time.strftime('%l:%M%P')} #{status[:user][:name]} https://twitter.com/#{status[:user][:screen_name]}/status/#{status[:id_str]} #{status[:geo][:coordinates][0]} #{status[:geo][:coordinates][1]} #{status[:user][:description]}",
               url: "https://twitter.com/#{status[:user][:screen_name]}/status/#{status[:id_str]}"
      }
    end
    @results
  end

  def get_json
    @data.to_json
  end

end
