require 'jumpstart_auth'
require 'bitly'
Bitly.use_api_version_3

class MicroBlogger 
	attr_reader :client

	def initialize
		puts "Initializing ..."
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		if message.length <= 140
			@client.update(message)
		else
			puts "Warning: Your tweet exceeds the 140 character limit."
			puts "Your tweet was not posted."
		end
	end

	def run
    puts "Welcome to the Richie's Twitter Client!"
    command = ""
    while command != "q"
    	printf "enter command: "
    	input = gets.chomp
    	parts = input.split(" ")
    	command = parts[0]
    	case command 
    	when 'q' then puts "Goodbye!"
    	when 't' then tweet(parts[1..-1].join(" "))
    	when 'dm' then dm(parts[1], parts[2..-1].join(" "))
    	when 'spam' then spam_my_followers(parts[1..-1].join(" "))
      when 'elt' then everyones_last_tweet
      when 's' then shorten(parts[1])
      when 'turl' then tweet(parts[1..-2].join(" ") + " #{shorten(parts[-1])}")
    	else
    		puts "Sorry, I don't know how to #{command}"
    	end
    end
  end

  def dm(target, message)
  	screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }

	  if screen_names.include?(target)
	  	puts "Trying to send #{target} this direct message:"
	  	puts message
	  	message = "d @#{target} #{message}"
	  	tweet(message)
	  else
	  	puts "Error: You can only DM people who follow you."
	  end
  end

  def followers_list 
  	screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
  end

  def spam_my_followers(message)
  	screen_names = followers_list
  	screen_names.each do |target|
  		dm(target, message)
  	end
  end

  def everyones_last_tweet
    friends = @client.friends.collect { |friend| @client.user(friend).screen_name.downcase }
    friends.sort!
    friends.each do |friend|
      timestamp = @client.user(friend).status.created_at
      message = @client.user(friend).status.text
      puts "#{@client.user(friend).screen_name} said this on #{timestamp.strftime("%A, %b %d")}..."
      puts message
      puts ""
    end
  end

  def shorten(original_url)
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    puts "Shortening this URL: #{original_url}"
    return bitly.shorten(original_url).short_url
  end
end

blogger = MicroBlogger.new
blogger.run
