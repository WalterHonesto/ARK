#!/usr/bin/awk -f

####################################################################################
#
# Programación Amateur si las hay
#
# Procesa las líneas de un archivo origen, si encuentra en un archivo fuente que
# tiene un símbolo de + entonces lo agrega en la copia del archivo origen
#
# Un problema con los archivos .txt hace que el print imprima el fin de linea
# Se recomienda usar .ini
#
####################################################################################

BEGIN {
print "############################ INICIO ################################"

fuente = "213Engram.txt"

}

{
# print "linea: " $1
# En el archivo origen obtengo el nombre del Engram
inigame = match($1, /\"*\"/)
fingame = match($1, "C\"")
# print inigame " - " fingame

# Si encuentra el match
if (inigame) {
	# Extrae el Engram
	eng = substr($1,inigame+1,fingame-inigame)
	# print "ENGRAM: " eng

	# Procesa el archivo fuente
	while ( (getline line < fuente) > 0 ) {
		# print "line: " line
		# Revisa si la línea contiene el Engram y un +
		hayMatch = match(line,eng)
		hayPlus = match(line,"\+")

		if (hayMatch && hayPlus) {
			print "ENGRAM: " eng
			print "MATCH: " line
			break
		}
	}
}
# print "################ saliendo ###############"
if (hayMatch && hayPlus) {
	# print "MATCH POSITIVO"
	nuevalinea = $1 "+"
	# print nuevalinea
	print nuevalinea > "migrarPlus.ini"
} else {
	# print "match negativo"
	print $1 > "migrarPlus.ini"
}

# print "SIGUIENTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
close(fuente)
}

END {
print "############################ FIN ################################"
}
