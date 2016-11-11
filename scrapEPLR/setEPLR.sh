#!/usr/bin/awk -f
BEGIN {print "######################## INICIO ########################"
# declaracion de textos constantes
}

{
print "##############################################################################################################################################################"
print "ANTES  : " $1
nuevalinea = $1

# En el archivo game.ini busca el nombre de la busqueda del engram delimitado por _ _C y el final del engram delimitado por _C
inigame = match(nuevalinea, /\"*\"/)
fingame = match(nuevalinea, "C\"")
print inigame " - " fingame

# Si encuentra el match
if (inigame) {
	# Extrae el engram y envia el wget a la wiki
	eng = substr(nuevalinea,inigame+1,fingame-inigame)
	print "ENGRAM: " eng

	# Procesa el html
	file = "todosEngramID.ini"
	while(( getline line < file ) > 0 ) {
		# Obtiene el engram que matchee
		inisearch = match (line,eng)

		if (inisearch){
			print "MATCH  : " line

			# Obtiene la ubicacion de los valores
			epini = match (line,/EngramPointCost/)
			epfin = match (line,/,EngramLevelRequirement/)

			lrini = match (line,/EngramLevelRequirement/)
			lrfin = match (line,/,RemoveEngram/)

			# print "epini: " epini
			# print "epfin: " epfin
			# print "lrini: " lrini
			# print "lrfin: " lrfin

			# Extrae los valores
			ep = substr(line,epini+16,epfin-epini-16)
			lr = substr(line,lrini+23,lrfin-lrini-23)
			# print "ep: " ep
			# print "lr: " lr

			# Salimos del While
			# print "prison"

			sub( /Cost=[0-9]*/,"Cost=" ep , nuevalinea )
			sub( /Requirement=[0-9]*/,"Requirement=" lr , nuevalinea )

			break
		}
	}

}

# Imprimo a archivo la línea final
print "DESPUES: " nuevalinea
print nuevalinea > "salida.ini"

close(file)
}

END {print "######################## FIN ########################"}
