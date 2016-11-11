#!/usr/bin/awk -f
#############################################################################
################## PROGRAMA INCOMPLETO ######################################
#############################################################################
#
# Programación Amateur si las hay
#
# La idea es:
# Obtener EP/LR de los Engram disponibles en la Wiki obteniendo del archivo
# origen algo parecido al Engram, luego hacer la búsqueda y hay que obtener
# el objeto y buscar en ese objeto el artículo en la wiki
#
# Quedé por el camino porque los bajé de un archivo general también obtenido
# a través de la Wiki
#
############################################################################


BEGIN {print "######################## INICIO ########################"
# declaracion de textos constantes
page="wget http://ark.gamepedia.com/"
busq ="index.php?search="
aux =" -o log"
}

{
# En el archivo game.ini busca el nombre de la busqueda del engram delimitado por _ _ y el final del engram delimitado por _C
inigame = match($1, /_*_/)
fingame = match($1, "_C\"")

# Si encuentra el match
if (inigame) {
	# Extrae el engram y envia el wget a la wiki
	eng = substr($1,inigame+1,fingame-inigame-1)
	print "ENGRAM: " eng
	system( page busq eng aux)
	print "FULL: " page busq eng aux

	# Procesa el html
	while(( getline line < (busq eng) ) > 0 ) {
		# Obtiene el primer resultado
		inisearch = match (line,/data-serp-pos="1">/)

		if (inisearch){
			# Extrae el nombre del objeto para hacer la consulta a la wiki
			objpos = match (line,/><a href="/)
			objfin = match (line,/" title=/)
			if (objpos){
				obj = substr(line,objpos+11,objfin-objpos-11)
				print "WGET FINAL: " page dir obj aux
			}

			# Envia el wget a la wiki
			system( page dir obj aux )

			while(( getline lineeng < obj ) > 0 ) {
				# print "lineeng: " lineeng
				lvlpos = match (lineeng,/Required level/)
				if (lvlpos) {
					print "lvlpos: " lvlpos
					# print lineeng
					# Si encuentro la linea, busco dos mas adelante
					getline lineeng < obj
					getline lineeng < obj
					# print lineeng
					lvlini = match (lineeng,/>Level</)
					print "lvlini: " lvlini
					reqlvl = substr(lineeng,lvlini+11,10)
					print "reqlvl: \"" reqlvl "\""
				}
			}
		}
	}

	# Borro el archivo de busqueda
	# system( "rm " busq eng )

	}

}

END {print "######################## FIN ########################"} ' $1
