# => * Name: reddit_bg_switch
# => * Author: Ameya Savale
# => * Github: https://github.com/asavale1/reddit_bg_switch
# => * OS: Ubuntu 
# => * 
# => * This script queries reddit based on the following parameters
# => *
# => * @SUBREDDIT
# => * @LIMIT
# => * @TIME_LIMIT
# => * @SORT_BY
# => * @NSFW
# => * 
# => * From the results of the query it randomly picks one post and downloads the image to the location defined by
# => *
# => * @LOCAL_BG_LOC
# => *
# => * It then proceeds to update the desktop background to the downloaded image
# => *
# => * [ See below for detailed explanations on parameters ]
# => *
# => *
# => * Usage:
# => *
# => * 	1. Save this file anywhere on your filesystem e.g. /home/user/reddit_bg_switch.rb
# => *	2. If ruby is not installed install ruby
# => *	3. Run $> ruby /home/user/reddit_bg_switch.rb 
# => *
# => *	Cron Setup
# => *	===============
# => *	If you would like this to run on a timer so that it 
# => *	switches your background every so often, follow the steps below
# => *
# => *	1. Run $> crontab -e
# => *	2. Select any editor if you haven't already
# => *	3. On a new line add something like the following
# => *
# => *		*/15 * * * * ruby /home/user/reddit_bg_switch.rb 
# => *		
# => *		This will change your desktop background every 15th minute of the hour e.g. 1:00, 1:15, 1:30, 1:45 ....
# => *

# => THE FOLLOWING ARE CUSTOMIZABLE PARAMETERS
# => 
#
# => Which subreddit do you want to get the image from
SUBREDDIT = "wallpapers"
#
# => The maximum number of results you want returned 
LIMIT = 20 # => (default: 25, maximum: 100)
#
# => The time limit within which you want to search
TIME_LIMIT = "month" # => hour | day | week | month | year | all
#
# => What do you want to sort by
SORT_BY = "hot" # => relevance | hot | top | new | comments
#
# => Allow nsfw posts in the results?
NSFW = "no" # => yes | no
#
# => Full path to local directory where the image will be saved
LOCAL_BG_LOC = "" # => e.g. /home/user/Pictures  
#
# => 
# => END OF CUSTOMIZABLE PARAMETERS
# => 
# => *********************************************************************

require 'json'
require 'net/http'
require "open-uri"

(puts "\nERROR: Please define the 'LOCAL_BG_LOC' variable in the script\n\n"; exit(1)) if LOCAL_BG_LOC.empty?

query = "q=nsfw:#{NSFW}&restrict_sr=on&sort=#{SORT_BY}&limit=#{LIMIT}&t=#{TIME_LIMIT}"
uri = URI.parse("https://www.reddit.com/r/#{SUBREDDIT}/search.json?#{query}")

request = Net::HTTP::Get.new(uri, {'User-Agent' => 'Desktop Script'})
response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https"){ |http| http.request(request) }

images_hash = JSON.parse(response.body)
image_url = images_hash["data"]["children"][rand(LIMIT)]["data"]["url"]

File.open("#{LOCAL_BG_LOC}/reddit_wallpaper", 'wb'){ |fo| fo.write open(image_url).read }
IO.popen("gsettings set org.gnome.desktop.background picture-uri file://#{LOCAL_BG_LOC}/reddit_wallpaper")
