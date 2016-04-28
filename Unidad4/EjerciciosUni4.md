**Ejercicio**: busca un artículo con datos y análisis parecidos a los que tendrás en tu proyecto y determina con qué programas y parámetros realizaron el pre-procesamiento. 

Algunas respuestas:

Del artículo Tedersoo L, Bahram M, Polme S et al. (2014) Global diversity and geography of soil fungi. Science, 346, 1256688–1256688.



``` 
# Separar barcodes con mothur1.32.2
# Recortar secuencias por calidad con Mothur con los parámetros: min lenght= 300; maxambig= 1; maxhomop=12; qwindowaverage=35; #qwindowsize=50; bdiffs=1.
# Quitar adaptadores con ITSx 1.0.7 para remover 5.8S y 28S
# Filtrar quimeras con UCHIME 4.2
```




