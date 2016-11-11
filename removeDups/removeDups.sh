#!/usr/bin/awk -f

#############################################################################
#
# Programación Amateur si las hay
#
# Busca por duplicados en un archivo de configuracion
# Si hay un duplicado, lo almacena hasta encontrar uno distinto
# Guarda siempre la última línea que no tenga 0 en el LR
# Devuelve otro archivo
#
############################################################################

BEGIN {
# print "######################## INICIO ########################"
# declaracion de textos constantes

# Inicial
auxeng = ""
auxlvl = ""
auxlinea = ""

salida = "filteredGame.ini"
}

{
inigame = match($1, /_*_/)
fingame = match($1, "_C\"")
eng = substr($1,inigame+1,fingame-inigame+1)

print "ENG: " eng
print "AUX: " auxeng

lrini = match ($1,/EngramLevelRequirement/)
lrfin = match ($1,/,RemoveEngram/)
lvl = substr($1,lrini+23,lrfin-lrini-23)

if (eng != auxeng) {
	# Si es distinto, ya puedo guardarlo
	print "ENGRAM DISTINTO"
	print auxlinea > salida
	auxeng = eng
	auxlinea = $1
} else if ( lvl != 0 ) {
	# Si es igual y el nivel es distinto de 0, almaceno el nivel
	print "ENGRAM IGUAL NIVEL DISTINTO DE 0"
	auxlinea = $1
}
	# Si es igual, y el nuevo es 0, me quedo con el anterior

}

END {
# print "######################## FIN ########################"
}
