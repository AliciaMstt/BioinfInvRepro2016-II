# Solución del primer examen parcial

#### Cuáles de los siguientes comandos puedo utilizar para ver el contenido (o parte de) de un archivo

```

cat

less

head

more

```

#### Si quiero ver los archivos de un directorio y el tamaño de cada archivo puedo usar (escoge todas las que apliquen)


```

ls -l

ls -lh

```

#### ¿Por qué es buena idea usar relative paths en nuestros scripts?

Para que puedan ser ejecutados con facilidad desde otras computadoras o usuarios sin tener que modificar el PATH del script

#### Asumiendo que te encuentras en el directorio BioinfInvRepro2016-II/Practicas/Uni2/Tomates/VerdesFritos ¿Cómo puedes ver el contenido de Practicas sin utilizar cd?


`ls ../../..` o `ls ../../../`

#### Dryad permite conectar los datos de un repositorio con los datos genéticos ya depositados en NCBI.

TRUE

#### ¿Qué info debe contener el README de un repositorio de datos y de un repositorio de código? (especifica para ambos casos)

Un README de un repositorio de código debe incluir:
-Que hay
-Que hace el código
-Como ejecuta la tarea el código (Qué archivos necesita, en qué orden, en qué software y versión del mismo etc.)

Un readme de un repositorio de datos debe incluír:
-Tipo de datos (RADsec, GBS, etc).
-Procesamiento de los datos crudos (Trimming, filtrado por calidad, demultiplex, etc.; incluyendo versión del software y parámetros utilizados)

En ámbos casos, es una buena idea ligarlos a la publicación de la que provienen.


#### ¿Con qué comando puedo ver el path del directorio donde me encuentro?

`pwd`

#### ¿Con qué línea de comando puedo hacer que un archivo ejecutable llamado miscript.sh DEJE de ser ejecutable (para el usuario)?


`chmod u-x miscript.sh`




#### Dentro de la carpeta Examen1/muestras encontrarás una serie de archivos con nombres como AATCAGTC.fs.

#### 1) Escribe un script en el recuadro de abajo que cambie el nombre de los
  15 primeros archivos (asumiendo orden alfabético) a muestra01, muestra02
y así sucesivamente.

#### 2) Asumiendo que tu script se llame renameSamples.sh ¿Qué linea de comando ocuparías para correrlo sin hacerlo un ejecutable?


```
#! /bin/bash

#cambiar el nombre de los archivos de forma manual
mv AATCAGTC.fs muestra01.fs
mv ACCGCCTC.fs muestra02.fs
mv AGAGATTC.fs muestra03.fs
mv CAAGACCC.fs muestra04.fs
mv CATCGTCC.fs muestra05.fs
mv CCGCTACC.fs muestra06.fs
mv CGCTTGAC.fs muestra07.fs
mv CTGCTGAC.fs muestra08.fs
mv GAAGCGCC.fs muestra09.fs
mv GATTGATC.fs muestra10.fs
mv GGCAAGGC.fs muestra11.fs
mv TATGCAGC.fs muestra12.fs
mv TCCGGAAC.fs muestra13.fs
mv TCTTCTGC.fs muestra14.fs
mv TTCAACCC.fs muestra15.fs
```


ojo no da solo los primeros 15, se podría modificar con un head
```
#! /bin/bash

# Este script renombra los archivos dentro del directorio muestras

n=0
for i in *.fs
do
mv "$i" "Muestra$((++n)).fs"
done
```

```

#! /bin/bash

#Primero se enlistan solo los primeros 5 archivps y después se cambian los nombres

ls *fs | grep -m 5 .fs | for i in *.fs; for j in {01..05}; do mv -v "$i" "muestra$j"
pipe pipe for for> done
```


`bash renameSamples.sh`


#### Escribe un script que concatene en un sólo archivo llamado tomates.fasta los archivos jitomate.fasta y tomatesverdes.fasta (están en /Practicas/Uni2/Tomates) y que luego cuente cuantas secuencias de Solanum hay en el archivo tomates.fasta. El resultado de la cuenta debe imprimirse en pantalla (no en un archivo)





