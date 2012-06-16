#libreridas usadas
require 'hpricot'
require 'open-uri'

#funciones locales de ayuda
def separa(tira)
	#función usada para separar album | banda
	tira = tira.split('|')
	return tira
end
module Extractor
	def Extractor.recibe(url)
		url = url;
		hp = Hpricot(open(url))
		
		#extracción de requerimiento de pago
		if (pago = hp.at("h4[@class='ft compound-button']"))
			pago = pago.at("a")
			pago = pago.search("").inner_html
		else
			pago = "unknow"
		end
		#extraccion de banda y album
		if (albumBanda = hp.at("title"))
			albumBanda = albumBanda.search("").inner_html
			albumBanda = separa(albumBanda)
		else
			albumBanda= ["unknow", "unknow"]
		end
		#extracción de url de bandcamp de la banda
		if (hp.at("div[@id='customHeader']") != nil)
			link = hp.at("div[@id='customHeader']")
			if ( link.at("a") != nil)
				link = link.at("a")['href']
			else
				link = url
			end
		else
			link = url
		end
		#valor de retorno ['banda', 'album', 'pago', 'link']
		return [albumBanda[1], albumBanda[0], pago, link]
	end
end


