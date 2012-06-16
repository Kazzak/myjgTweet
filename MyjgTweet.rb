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

# librerias requeridas para el correcto funcionamiento del programa
require 'oauth'
require 'twitter'

class MyjgTweet

	# Inicializa variables para uso del programa, como la llave a usar
	# y la llave secreta, y una variable para definir la cuenta a la 
	# que se ingreso
	
	def initialize()
		@consumer_key = "vQKk4GpAKdYaXA5lCcTY6g"
		@consumer_secret = "74zyUeAEFsbVOBQCmJOGWNgHUh6vOMSBQE8mibrFxA"
		$client
	end
	
	# Funcion que realiza la peticion de datos y solicita los permisos 
	# de la cuenta del usuario 
	
	def login()
	
		# Codigo que realiza la conexion con la api de Twitter que posee
		# las llaves de acceso al programa, asi como el sitio al que se 
		# dirigira, junto con las direcciones a las que solicitara datos
		# para la autenticacion
		
		solConexion=OAuth::Consumer.new(
			@consumer_key, 
			@consumer_secret, 
			{
				:site=>"http://twitter.com",
				:request_token_url=>"https://api.twitter.com/oauth/request_token",
				:access_token_url =>"https://api.twitter.com/oauth/access_token",
				:authorize_url    =>"https://api.twitter.com/oauth/authorize"
			}
		)
		
		# Codigo donde se solicita el token de acceso secreto y la 
		# direccion para confirmar los datos de la cuenta, o si el 
		# usuario posee una cuenta de Twitter
		request_token = solConexion.get_request_token
		key2 = request_token.token
		secret2 = request_token.secret
		dir = solConexion.authorize_url + "?oauth_token=" + key2
		puts "   "
		puts ("Por favor ingrese al siguiente enlace. Para accesar de 
forma directa manten presionado la tecla Ctrl y dale un 
click al enlace")
		puts "   "
		puts "Enlace: \"#{dir}\""
		puts "   "
		print ("Por favor ingrese el PIN que la pagina de Twitter genero
para completar el proceso de autorizacion: ")
		pin = STDIN.readline.chomp
		puts "   "
		
		# Seccion del codigo donde se valida el PIN y los datos 
		# ingresados por el usuario. Luego de verificar los datos, 
		# configura la variable Twitter con los datos de acceso del
		# usuario y crea una nueva instancia de la cuenta
		
		begin
			OAuth::RequestToken.new(solConexion, key2, secret2)
			access_token=request_token.get_access_token(:oauth_verifier => pin)
			Twitter.configure do |config|
				config.consumer_key = @consumer_key
				config.consumer_secret = @consumer_secret
				config.oauth_token = access_token.token
				config.oauth_token_secret = access_token.secret
			end
			$client = Twitter::Client.new
			$client.verify_credentials
			puts "Usuario autenticado correctamente"

		rescue Twitter::Unauthorized
			puts "Error de Autorizacion"
		end
	end
	
	# envía una actualización de estado de Twitter
	
	def twitt()
		$client.update ("la salida a la biblioteca de twitter y oauth ")
	end
	
end

# __FILE__  es la variable que contiene el nombre del archivo que se 
# está ejecutando en el momento
# $0 es el nombre del archivo usado para iniciar el programa
# Los demas datos son para llamar los metodos de la clase

if __FILE__ == $0
	x = MyjgTweet.new
	x.login
	x.twitt
end
