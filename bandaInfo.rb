#modulos de trabajo
load 'extraeLinks.rb'
load 'extraeInfo.rb'


#librerias usadas
require 'pp'

class Banda
	#metodo constructor
	def initialize(nombre, album, pago, link)
		@nombre = nombre
		@album = album
		@pago = pago
		@link = link
	end
	#metodos get's
	def getNombre
		@nombre
	end
	def getAlbum
		@album
	end
	def getPago
		@pago
	end
	def getLink
		@link
	end
end

class Consulta
	#metodo constructor
	def initialize(url)
		@info = []
		@url = url
		@links = Links.recibe(url)
		@links.each do |subLink|
			var =  Extractor.recibe(subLink)
			temp = Banda.new(var[0], var[1], var[2], var[3])
			@info+= [temp]
		end
	end
	#metodos get's
	def getUrl
		@url
	end
	def getLinks 
		@links
	end
	def getInfo
		return @info
	end
	
end

module ObtenerInfo
	def ObtenerInfo.cargaArray(url)
		var = Consulta.new(url)
		var.getInfo
	end
end

