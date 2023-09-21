#!/bin/bash

# Argumento $1: ID de un proceso

# Revisa que el usuario ingrese solo un argumento
if [ $# -ne 1 ]; then
	echo "Debe introducir un ID de un proceso"
	exit 1
fi

# Se imprime lo solicitado
echo "Nombre: $(ps -p "$1" -o comm --no-header)"
echo "ID del proceso: $(ps -p "$1" -o pid --no-header)"
echo "Parente process ID: $(ps -p "$1" -o ppid --no-header)"
echo "Usuario propietario: $(ps -p "$1" -o suser --no-header)"
echo "Porcentaje del CPU actual: $(ps -p "$1" -o %cpu --no-header)"
echo "Consumo de memoria: $(ps -p "$1" -o %mem --no-header)"
echo "Estado: $(ps -p "$1" -o stat --no-header)"
echo "Path del ejecutable: $(readlink -f /proc/"$1"/exe)" 
