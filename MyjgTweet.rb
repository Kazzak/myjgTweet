#  MyjgTweet.rb
#  
#  Copyright 2012 Ricardo P. Gago <rgago@Gago48>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
# 

require 'oauth'
require 'twitter'

class MyjgTweet

	def initialize()
		@consumer_key = "vQKk4GpAKdYaXA5lCcTY6g"
		@consumer_secret = "74zyUeAEFsbVOBQCmJOGWNgHUh6vOMSBQE8mibrFxA"
		$client
	end
	
	def login()
		consumer=OAuth::Consumer.new(
			@consumer_key,
			@consumer_secret,
			{
				:site=>"http://twitter.com",
				:request_token_url=>"https://api.twitter.com/oauth/request_token",
				:access_token_url =>"https://api.twitter.com/oauth/access_token",
				:authorize_url    =>"https://api.twitter.com/oauth/authorize"
			}
		)
		request_token = consumer.get_request_token
		tokenx = request_token.token
		secretx = request_token.secret
		dir = consumer.authorize_url + "?oauth_token=" + tokenx
		puts "Place \"#{dir}\" in your browser"
		print "Enter the number they give you: "
		pin = STDIN.readline.chomp
		
		begin
			OAuth::RequestToken.new(consumer, tokenx, secretx)
			access_token=request_token.get_access_token(:oauth_verifier => pin)
			Twitter.configure do |config|
				config.consumer_key = @consumer_key
				config.consumer_secret = @consumer_secret
				config.oauth_token = access_token.token
				config.oauth_token_secret = access_token.secret
			end
			$client = Twitter::Client.new
			$client.verify_credentials
			puts "Autenticado Correctamente"

		rescue Twitter::Unauthorized
			puts "Error de Autorizacion"
		end
	end
	
	def twitt()
		$client.update ("la salida a la biblioteca de twitter_oauth ") # envía una actualización de estado de Twitter
	end
	
end

if __FILE__ == $0
	x = MyjgTweet.new
	x.login
	x.twitt
end
