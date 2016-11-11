#!/usr/bin/awk -f

#############################################################################
#
# Programación Amateur si las hay
#
# Provisto el archivo de origen $1, se fija si tiene un + en la línea
# Si tiene un +, sobreescribe el false con el true
# Deja el +, se puede sacar con un reemplazar posteriormente
# Devuelve otro archivo
#
############################################################################

BEGIN {
# declaracion de textos constantes
}

{
print "ANTES  : " $1
nuevalinea = $1

# Buscar en la línea si tiene el + al final
plus = match(nuevalinea, "\+")

if (!plus) {
	sub("EngramHidden=false","EngramHidden=true",nuevalinea)
}

print "DESPUES: " nuevalinea
print nuevalinea > "Game-ifnotplushidden.ini"

}

END {
}
