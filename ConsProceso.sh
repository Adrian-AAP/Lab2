#!/bin/bash

# Argumento: un ejecutable

function plotmem(){
	load "LogMemoria.txt"
	set term png
	set output "Grafica.png"
	set title "Memoria"
	set xlabel "Tiempo"
	set xdata time;
	set timefmt "%H:%M:%S"
	set ylabel "Consumo"
	plot 'LogMemoria.txt' using 1:2 with lines
}

function plotcpu(){
	load "LogCPU.txt"
	set term png
	set output "Grafica.png"
	set title "CPU"
	set xlabel "Tiempo"
	set xdata time
	set timefmt "%H:%M:%S"
	set ylabel "Consumo"
	plot 'LogCPU.txt' using 1:2 with lines
}
if [ $# -ne 1 ]; then
	echo "Solo debe ingresar un parametro"
fi

logmem=$"LogMemoria.txt"
logcpu=$"LogCPU.txt"



./"$1" & #Ejecutar el binario sin detenerse

#Crear logs
touch $logmem 
touch $logcpu


activo=1
while [ $activo -eq 1 ]	
do 
	$(ps -C "$1" > /dev/null)
	if [ $? -eq 0 ]; then
		cpu=$(ps -C "$1" -o %cpu --no-header)
		mem=$(ps -C "$1" -o %mem --no-header)
		temp=$(date +"%H:%M:%S")
			
		#Escribir en logs
		echo "$temp  $cpu" >> $logcpu
		echo "$temp  $mem" >> $logmem

		sleep 30s #Espera 30 segundos
	else
		activo=1
		
		gnuplot plotmem
		gnuplot plotcpu
	fi
done

#Eliminar logs
rm LogMemoria.txt
rm LogCPU.txt
