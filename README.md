# Reddit BG Switch

## Author

Ameya Savale

##

This script queries reddit based on the following parameters

SUBREDDIT, LIMIT, TIME_LIMIT, SORT_BY, NSFW
 
From the results of the query it randomly picks one post and downloads the image to the location defined by

LOCAL_BG_LOC

It then proceeds to update the desktop background to the downloaded image

## Usage
1. Pick the right script for your OS and save it anywhere on your local file system *e.g. /home/user/reddit_bg_switch.rb*
2. If ruby is not installed, install ruby **https://rvm.io/**
3. Run **$> ruby /home/user/reddit_bg_switch.rb**

### Setting up CRON
If you would like this to run on a timer so that it switches your background every so often, follow the steps below

#### Linux
1. Run **$> crontab -e**
2. Select an editor if you haven't already
3. On a new line add something like the following

   __*/15 * * * * ruby /home/user/reddit_bg_switch.rb__
   
   This will change your desktop background every 15th minute of the hour e.g. 1:00, 1:15, 1:30, 1:45 ....
