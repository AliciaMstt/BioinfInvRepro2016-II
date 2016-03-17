# Docker file ejemplo
FROM ubuntu:latest

RUN mkdir /Prueba
VOLUME ["DatosContenedorAnalisis1"]


## Para construir la imagen basada en este dockerfile escribir en la terminal (WD al docker file)
# docker $(docker-machine config default) build -t miproyecto/analisis1:v1 . 

# miproyecto es el nombre del repositorio y analsis1:v1 el de la imagen y la versión 
# $(docker-machine config default) está diciéndole al cliente donde está el demonio (que es un servicio), es decir que configure el default
# correr docker-machine config default para ver las flags que se van a pasar al cliente de docker

## Para correr un proceso dentro del contenedor
# docker $(docker-machine config default) run -v /Users/ticatla/Copy/Science/Teaching/Mx/BioinfInvgRepro/BioinfInvRepro2016-II/Practicas/Uni5/datos:/DatosContenedorAnalisis1 -it miproyecto/analisis1:v1 /bin/bash