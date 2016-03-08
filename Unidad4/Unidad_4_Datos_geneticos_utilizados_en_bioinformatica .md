# Unidad 4 Datos genéticos utilizados en bioinformática 

Referencias recomendadas para esta Unidad:

* [Next Generation Sequencing (NGS)/Pre-Processing - Wikibooks, Open Books for an Open World (2014)](http://en.wikibooks.org/wiki/Next_Generation_Sequencing_(NGS)/Pre-processing#Sequence_Quality)

	

## 4.1. Datos crudos 	

### ¿Qué son los datos *crudos*?

Son las secuencias tal cual salen de la plataforma de secuenciación (Illumina, IonTorrent, PacBio, entre otros). Es decir los **reads** (lecturas).  


Los datos crudos (sin importar la plataforma y el método de laboratorio utilizado) conllevan cierto nivel de basura, es decir:

* *reads* de baja calidad que deben ser descartados por completo o en parte (*trimmed*) antes de proceder a los análisis biológicos de los datos. 

* Secuencias sobrerepresentadas, por ejemplo dímeros de adaptadores.

La longitud y distribución de la calidad de los *reads* varían de plataforma a plataforma, pero también el tipo de error más común:

* Illumina: errores puntuales en la asignación de un nucleótido
* IonTorrent y símiles: se les complica determinar el número correcto de nucleótidos en cadenas como AAAAA.

Dado que los datos crudos son muy pesados (espacio de disco) y que buena parte de los datos crudos son basura, en general los datos crudos a este nivel no se guardan en repositorios públicos (e.g. SRA) hasta que hayan pasado por los filtros del pre-procesamiento.

Como veremos más adelante, los filtros de pre-procesamiento ayudan a identificar las buenas secuencias de la basura a partir de su calidad asociada.


## 4.2. Información en los archivos FASTQ 		
### Representación de secuencias

En cómputo las secuencias de ADN son una *string* (cadena) de caracteres. 

* Secuencias genómicas

{A,C,G,T}+

* Secuencias mRNA

{A,C,G,U}+



##### Secuencias simples: FASTA/Pearson Format

Línea 1: información de la secuencia

Línea 2: la secuencia.

```

>gi|365266830|gb|JF701598.1| Pinus densiflora var. densiflora voucher Pf0855 trnS-trnG intergenic spacer, partial sequence; chloroplast
GCAGAAAAAATCAGCAGTCATACAGTGCTTGACCTAATTTGATAGCTAGAATACCTGCTGTAAAAGCAAG
AAAAAAAGCTATCAAAAATTTAAGCTCTACCATATCTTCATTCCCTCCTCAATGAGTTTGATTAAATGCG
TTACATGGATTAGTCCATTTATTTCTCTCCAATATCAAATTTTATTATCTAGATATTGAAGGGTTCTCTA
TCTATTTTATTATTATTGTAACGCTATCAGTTGCTCAAGGCCATAGGTTCCTGATCGAAACTACACCAAT
GGGTAGGAGTCCGAAGAAGACAAAATAGAAGAAAAGTGATTGATCCCGACAACATTTTATTCATACATTC
AGTCGATGGAGGGTGAAAGAAAACCAAATGGATCTAGAAGTTATTGCGCAGCTCACTGTTCTGACTCTGA
TGGTTGTATCGGGCCCTTTAGTTATTGTTTTATCAGCAATTCGCAAAGGTAATCTATAATTACAATGAGC
CATCTCCGGAGATGGCTCATTGTAATGATGAAAACGAGGTAATGATTGATATAAACTTTCAATAGAGGTT
GATTGATAACTCCTCATCTTCCTATTGGTTGGACAAAAGATCGATCCA

```


##### Fastq: formato para secuencias de secuenciación de siguiente generación

Secuencia fasta + detalles calidad de la información (la Q es de Quality).

* Línea 1: Encabezado (*Header*): comienza con @. Sigue el identificador (*identifier*). Si son datos crudos contiene info del secuenciador que identifica a esta secuencia y el read pair (/1 o /2), si son datos ya procesados en SRA contiene una descripción de la secuencia.

* Línea 2: la secuencia. 

* Línea 3: Comienza con +. Puede ser sólo el símbolo + o repetir la info del Header. 

* Línea 4: Información de la calidad de secuenciación de cada base. Cada letra o símbolo representa a una base de la secuencia codificado en formato [ASCII](http://ascii.cl/). 


La info de calidad se codifica en ASCII porque esto permite en 1 sólo caracter codificar un valor de calidad. Por lo tanto la línea 2 y la 4 tienen el mismo número de caracteres. 
 

Ordenados de menor a mayor estos son los caracteres ASCII usados para representar calidad en FASTQ:

```
!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
```
Dependiendo del tipo y versión de plataforma de secuenciación se toman diferentes caracteres (pero sin desordenarlos):


![ascii_fastqplataformas.PNG](ascii_fastqplataformas.PNG)

(Tomé la imágen de [aquí](http://en.wikibooks.org/wiki/Next_Generation_Sequencing_(NGS)/Pre-processing#Sequence_Quality)
)

Pero en todos los casos el **valor máximo de calidad es = ~40** y los valores **< 20 se consideran bajos**.


**Ojo:**
 @ y + están dentro de los caracteres ASCII utilizados para codificar la calidad, lo que hace que usar `grep` en archivos FASTQ pueda complicarse, ojo.

**Ejemplos:**

Ejemplo de datos FASTQ recién salidos de Illumina:

```
@HWI-ST999:102:D1N6AACXX:1:1101:1235:1936 1:N:0:
ATGTCTCCTGGACCCCTCTGTGCCCAAGCTCCTCATGCATCCTCCTCAGCAACTTGTCCTGTAGCTGAGGCTCACTGACTACCAGCTGCAG
+
1:DAADDDF<B<AGF=FGIEHCCD9DG=1E9?D>CF@HHG??B<GEBGHCG;;CDB8==C@@>>GII@@5?A?@B>CEDCFCC:;?CCCAC
```
Y uno más:

```
@OBIWAN:24:D1KUMACXX:3:1112:9698:62774 1:N:0:
TAATATGGCTAATGCCCTAATCTTAGTGTGCCCAACCCACTTACTAACAAATAACTAACATTAAGATCGGAAGAGCACACGTCTGAACTCAGTCACTGACC
+
CCCFFFFFHHHHHIJJJJJJJJJJJJIIHHIJJJJJJJJJJJJJJJJJJJJIJJJJJJIJJJJIJJJJJJJHHHHFDFFEDEDDDDDDDDDDDDDDDDDDC

```
¿Quieres saber cuáles son las partes del Header? [Clic aquí](https://en.wikipedia.org/wiki/FASTQ_format#Illumina_sequence_identifiers). Y sí, el último ejemplo es real y por lo tanto hay un Illumina HiSeq2000 que se llama Obiwan :)

 Ejemplo de datos FASTQ del SRA:

```
@SRR001666.1 071112_SLXA-EAS1_s_7:5:1:817:345 length=36
GGGTGATGGCCGCTGCCGATGGCGTCAAATCCCACC
+SRR001666.1 071112_SLXA-EAS1_s_7:5:1:817:345 length=36
IIIIIIIIIIIIIIIIIIIIIIIIIIIIII9IG9IC
```




Los datos FASTQ típicamente están comprimidos en formato 
`gzip` (.gz) o `tar` (.tar.gz o .tgz).

**Ejercicio**:

En la Unidad 1 vimos cómo descomprimir archivos .tar.gz ¿Cómo descomprimir un archivo .gz?



## 4.3. Análisis básicos de calidad y preparación de datos (Pre-procesamiento)

### Visualización e interpretación de la calidad de secuencias FASTQ

Antes de saltar a filtrar tus datos con filtros de calidad que la terminal ejecute muy obediente, lo mejor es ver algunos gráficos básicos que nos dicen mucho más que una serie semi-eterna de caracteres ASCII. 

[FASTQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/) es un programa que hace una serie de análisis básicos y estándar de calidad. La mayoría de las empresas de secuenciación efectúan este análisis y te mandan los resultados junto con tus datos crudos.

Los análisis de FASTQC son útiles para identificar problemas que pudieron surgir durante el laboratorio o durante la secuenciación. 

El análisis de FASTQC consiste en los siguientes campos:


* [Basic Statistics](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/1%20Basic%20Statistics.html)
* [Per Base Sequence Quality](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/2%20Per%20Base%20Sequence%20Quality.html)
* [Per Sequence Quality Scores](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/3%20Per%20Sequence%20Quality%20Scores.html)
* [Per Base Sequence Content](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/4%20Per%20Base%20Sequence%20Content.html)
* [Per Sequence GC Content](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/5%20Per%20Sequence%20GC%20Content.html)
* [Per Base N Content](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/6%20Per%20Base%20N%20Content.html)
* [Sequence Length Distribution](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/7%20Sequence%20Length%20Distribution.html)
* [Duplicate Sequences](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/8%20Duplicate%20Sequences.html)
* [Overrepresented Sequences](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/9%20Overrepresented%20Sequences.html)
* [Adapter Content](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/10%20Adapter%20Content.html)
* [Kmer Content](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/11%20Kmer%20Content.html)
* [Per Tile Sequence Quality](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/12%20Per%20Tile%20Sequence%20Quality.html)

**Notas importantes:**

* FASTQ automáticamente dice si nuestra muestra "pasó" o "falló" la evaluación. Sin embargo debemos tomar esto dentro del **contexto de lo que esperamos de nuestra librería**, ya que FASTQ espera una distribución al diversa y al azar de nucleótidos, lo que puede no cumplirse en algunos protocolos.



Vamos a la página de dicho programa a ver ejemplos de:

* [Buenos datos Illumina](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/good_sequence_short_fastqc.html)
* [Malos datos Illumina](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/bad_sequence_fastqc.html)
* [Corrida Illumina contaminada con dímeros de adaptadores (*adapter dimers*)](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/RNA-Seq_fastqc.html)


**¿Qué que son los dímeros de adaptadores?**

Los adaptadores se ligan al ADN de nuestras muestras en un paso de ligación, sin embargo, también pueden ligarse entre sí y luego pegarse a la *flow cell* (que lo traduzca quién sepa cómo). Resultado: son secuenciados pero no proven datos útiles, simplemente la secuencia de los adaptadores repetida  muchas veces. Adelante veremos cómo lidiar con ellos bioinformáticamente, pero se recomienda intentar deshacerse de ellos desde el laboratorio (con pequeños, pequeños imanes como [Agencourt](https://www.beckmancoulter.com/wsrportal/wsrportal.portal;jsessionid=jhp2WT8G5B4zYXhzKCPnWk8J1n3TL1JRGLsDbp130t9VRWtbFrY4!-1744838288!-683502135?_nfpb=true&_windowLabel=UCM_RENDERER&_urlType=render&wlpUCM_RENDERER_path=%2Fwsr%2Fcountry-selector%2Findex.htm&_WRpath=%252Fwsr%252Fresearch-and-discovery%252Fproducts-and-services%252Fnucleic-acid-sample-preparation%252Fagencourt-ampure-xp-pcr-purification%252Findex.htm&intBp=true) o símiles de otras marcas). 


**¿Qué tanto importa el análisis FASTQC?**

Mucho, a partir del análisis FASTQC es que decidirás si tu secuenciación fue exitosa y qué parámetros de pre-procesamiento deberás utilizar para deshacerte del ruido y quedarte con **datos limpios**. 

Escoger los parámetros adecuados de pre-procesamiento es vital ya que todas las corridas de secuenciación son diferentes. Lo más seguro es que el default del programa o lo que Perenganos *et al* 2015 reportaron en su artículo magno no sea lo mejor para procesar **tus** datos.

Además entender bien tu FASTQC puede permitirte **rescatar** datos usables incluso dentro de una mala corrida. 

### Pre-procesamiento 

El pre-procesamiento se refiere al filtrado y edición de los datos crudos para quedarnos con los **datos limpios**, que son los que se analizarán para resolver preguntas biológicas.

El input son archivos .fastq y el output son también archivos .fastq (o más posiblemente sus versiones comprimidas).

El pre-procesamiento por lo común incluye los siguientes pasos:

##### Recortar secuencias por calidad (*Sequence Quality Trimming*)
Recortar (quitar) las bases de baja calidad de la secuencia. En Illumina por lo general se trata de las últimas bases (-3' end). Cuántas bases cortar puede determinarse tras la inspección visual de análisis FASTQC o automáticamente con un parámetro de calidad. 

**Factor a considerar**: algunos programas de ensamblado requieren que las secuencias a ensamblar sean del mismo largo, por lo que si ocuparás uno de esos programas es necesario recortar todos tus datos al mismo largo (incluso si se secuenciaron en lanes distintas y una tiene buena calidad).

##### Recortar secuencias (*Trimming*)
Recortar (quitar) x bases de la secuencia porque no nos interesa conservarlas para el análisis (por ejemplo barcodes o sitios de restricción). 

##### Filtrar secuencias por calidad
Remueve del conjunto de datos todas las secuencias que estén por debajo de un mínimo de calidad (número de bases con calidad <x, promedio de calidad <x y símiles).

##### Quitar adaptadores 
Busca la secuencia de los adaptadores y los recorta de las secuencias finales. También es posible limitar las secuencias finales a sólo aquellas con un adaptador especificado (en vez de otro que pudiera ser contaminación). 

##### Filtrar artefactos
Detecta primers de PCRs, quimeras y otros artefactos y los desecha de los datos finales.

##### Separar por barcodes "demultiplexear" (*demultiplexing*)
Identifica las secuencias que contienen uno o más *barcodes* (también llamado índices), que son secuencias cortas (4-8 bp por lo general) que se incluyen en los adaptadores y que son únicos por muestra. Esto permite identificar y separar todas las secuencias pertenecientes a una muestra de otra secuenciadas al mismo tiempo. 

Requiere que le demos la lista de barcodes utilizados y en qué extremo se localizan. Muchos programas tendrán como output un archivo llamado algo como GATCATGC.fastq.gz, donde se encuentran todas las secuencias del barcode GATCATGC. El nombre de tu muestra deberás ponerlo en un paso subsecuente.

**Ojo** Tu lista barcodes-nombremuestra es de la info más valiosa de tu proyecto, no la pierdas.

##### *Paired end merging*
Si se realizó secuenciación Illumina a ambos lados (*pair end*) es posible unir las lecturas si se detecta que coinciden (aunque sea parcialmente). Esto permite corregir errores de secuenciación al tomar la base de la lectura de mayor calidad.

##### Remover otras secuencias no deseadas
Busca secuencias no deseadas, como genoma de *E. coli*, restos de PhiX o partes del genoma que no son de interés (e.g. cpDNA).  

**Ejercicio**: busca un artículo con datos y análisis parecidos a los que tendrás en tu proyecto y determina con qué programas y parámetros realizaron el pre-procesamiento. 

#### Software para realizar el pre-procesamiento

##### Línea de comando con programa especializado

La mayoría de los pasos del pre-procesamiento puede hacerse con programas dedicados a esto como [FASTX-Toolkit](http://hannonlab.cshl.edu/fastx_toolkit/), pero también algunos programas especializados (e.g. en datos RAD, como pyRAD o Stacks) tienen sus propios módulos para el pre-procesamiento. 

Es importante hacer el pre-procesamiento acorde a la naturaleza y calidad de nuestros datos. 


**Ejercicio**

El siguiente ejercicio lo realizaremos en Galaxy, que es un servidor que permite hacer análisis bioinformáticos a través de una página web, aunque en realidad en los servidores los programas corren con la líea de comando. 

Galaxy es útil para realizar ciertos análisis sin tener que instalar nada, pero posiblemente lo que requieras hacer no está en Galaxy o tus datos sean demasiado grandes para sus servidores. De cualquier modo puedes utilizar Galaxy para diseñar tu pipeline con un subset de tus datos y posteriormente correrlos via línea de comando en otro servidor.



1) Entra a [https://usegalaxy.org/](https://usegalaxy.org/) y crea una cuenta (Usuario > Register).

2) Toma el tour virtual a Galaxy (Galaxy UI)

Lo encuentras en el menú Help:

![galaxy_interactivetour.PNG](galaxy_interactivetour.PNG)

3) Crea una historia nueva llamda "Prueba pre-procesamiento"

![galaxy_namehistory.PNG](galaxy_namehistory.PNG)

4) Baja datos de prueba de Galaxy 

    Shared Data-> Data Libraries deprecated ->Sample NGS Datasets-> Import  human illumina dataset to your current history.

En el último paso deberás ver algo así:

![galaxy_importdataset.PNG](galaxy_importdataset.PNG)

5) Ve al menu **Analyze Data** para hacer un **FastQC Read Quality report**. Está dentro de **NGS: QC and manipulation**, en el menú de herramientas de la izquierda

![galaxy_fastqc.PNG](galaxy_fastqc.PNG)

Tardará un rato en correr. Mientras tanto tendrás una pantalla así:

![galaxy_fastqccola.PNG](galaxy_fastqccola.PNG)

Cuando termine deberás ver algo así:

![galaxy_fastqcresults.PNG](galaxy_fastqcresults.PNG)

Explora los resultadps deñ FastQC ¿Qué puedes decir sobre la calidad de estos datos? 

6) Explora las otras herremientas de **NGS: QC and manipulation**. ¿Cuál elegirías para limpiar las secuencias obtenidas? ¿Con qué parámetros?

7) Realiza la limpieza de los datos según lo que decidiste en el punto anterior.

Cada paso se hace de forma independiente y necesita los datos del paso anterior para poder seguir. 

Una vez que terminó un análisis puedes dar click en ese paso para ver los resultados (eg. nuevo set de secs fastq) y sus atributos.

![galaxy_filtradoresults_atr.PNG](galaxy_filtradoresults_atr.PNG)

Si das click en el símbolo de info (i) puedes ver el detalle completo del programa que corrió:

![galaxy_filtradoresults_info.PNG](galaxy_filtradoresults_info.PNG)


Y puedes volver a correr el FastQC sobre los datos ya limpiados, para ver si los métodos y parámetros que escogiste funcionan como deseas y si sería necesario hacer algo más.

![galaxy_fastqcafterfilter.PNG](galaxy_fastqcafterfilter.PNG)

Puedes ver esta historia aquí:

[https://usegalaxy.org/u/aliciamstt/h/prueba-pre-procesamiento](https://usegalaxy.org/u/aliciamstt/h/prueba-pre-procesamiento)

Para generar ese link, ve a las herramientas (ruedita engrane) de historia y dale en **Share history**.



## 4.4. Datos procesados

and more stuff here. Feliz siguiente clase teórica







