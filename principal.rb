require 'pp'
#modulos de trabajo
load 'extraeLinks.rb'
load 'extraeInfo.rb'
load 'bandaInfo.rb'
load 'haceTweet.rb'

def desglosa(objeto)
	tira = ""
	tira+= objeto.getNombre()
	tira+= ","
	tira+= objeto.getAlbum()
	tira+= ","
	tira+= objeto.getPago()
	tira+= ","	
	tira+= objeto.getLink()
	return tira
end
def procesa(tag)
	lista= tag.split(" ")
	nueva= ""
	count = 0
	lista.each do |x|
		if count == 0
			nueva+=x
			count+=1
		else
			nueva+='-'
			nueva+=x
		end
	end
	return nueva
end

# __FILE__  es la variable que contiene el nombre del archivo que se 
# está ejecutando en el momento
# $0 es el nombre del archivo usado para iniciar el programa
# Los demas datos son para llamar los metodos de la clase

if __FILE__ == $0
	
	print ("ingrese la consulta: ")
	tag = STDIN.readline.chomp
	if tag.length() == 0
		abort("No ingreso nada")
	end
	#objetos para tweet's
	sesion = GeneraTweet.inicia()	
	
	tag = procesa(tag)
	#objetos para bandcamp
	url = "http://bandcamp.com/tag/"
	url+=tag
	info = ObtenerInfo.cargaArray(url)
	info.each do |objeto|
		tira = desglosa(objeto)
		GeneraTweet.generar(tira, sesion)
	end
	
end
