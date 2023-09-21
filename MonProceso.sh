#!/bin/bash

# Primer argumento: Nombre del proceso
# Segundo argumento: Comando para ejecutar proceso

if [ $# -ne 2 ]; then
	echo "Debe introducir exactamente 2 parametros"
fi

count=$(pgrep -c "$1"

if [ $count -eq 0 ]; then
	echo "No hay ningun proceso con este nombre"
	exit 1
elif [ $count -gt 1 ]; then
	echo "Hay $count procesos con el mismo nombre"
	exit 1
fi

id=$(pgrep -m "$1")

while true
do
	$(ps -p $id > /dev/null)
	if [ $? -eq 0 ]; then
		./InfProceso.sh $id
		sleep 30s #30 segundos
	else
		./"$2" #Ejecuta el proceso
	fi
done
