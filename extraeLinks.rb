#librerias usadas
require 'hpricot'
require 'open-uri'
require 'pp'

#modulo para extracción de Links
module Links
	def Links.recibe(url)
		array = []
		count = 0	
		url = url;
		hp = Hpricot(open(url))
		
		#proceso de extraccion
		var = hp.search("li[@class='item']")
		var.each do |x|
			var2 = x.at("a")['href']
			if count <= 9
				array+=[var2]
				count+=1
			else
				return array
			end
		end
		return array
	end
end
