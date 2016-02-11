# Representación de secuencias

En cómputo las secuencias de ADN son (cadena) *string* de caracteres. 

* Secuencias genómicas

{A,C,G,T}+

* Secuencias mRNA

{A,C,G,U}+



* Secuencias simples: FASTA/Pearson Format

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


* Multi-Fasta format:

Una secuencia fasta seguida de otra.


* Fastq: formato para secuencias de secuenciación de siguiente generación

Secuencia fasta + detalles calidad de la información.

Línea 1: Header: comienza con @. Sigue el identificador (*identifier*). Contiene info del secuenciador que identifica a esta secuencia y el read pair (/1 o /2). 
Línea 2: la secuencia. 
Línea 3: Comienza con +. Puede ser sólo el símbolo + o repetir la info del Header. 
Línea 4: Información de la calidad de secuenciación de cada base. Cada letra o símbolo representa a una base de la secuencia.


**Base quality scores** 

Let pb = probabilidad de que el llamado de la base b es correcto
Quality value: Qsanger = -10 log10pb (integer)
Sanger (Phred quality scores): valor de 0-93, pero escritos como los ASCII characters 33-126


Maximal quality value = ~40
Quality values < 20 son bajos. 


## Genome annotation
Determinar la localización precisa y estructura (intervalos, listas de intervalos e info biológica asociada a ellos) de características genómicas (genes, promotores, sitios de inicio/fin de la traducción, etc) a lo largo del genoma. 

Eg: 
coordenadas de inicio/fin de exon/intron




## BED format
Basic:
#Chr start end

Extendend
#Chr start end name score strand thick_start thick_end rgb


Diferentes formas de contar inicio/fin
0-based: cuenta espacios
1-based: cuenta las bases


## Formato GTF 
"Genetic transfer format"

Representar genes

#chr program feature start end strand frame gene_id; txpt_id

Cada intervalo toma una línea, con info en difernetes columnas.
Columnas 1-9 separadas por tab y campso *dentro* de la col 9 separados por espacio.
La columna 9 es compuesta y puede tener varios atributos: mínimo el identificador (id) del gen, y luego 
Las coordenadas son 1-based


## GFF3
Genomic feature format

#chr source feature start end starand frame ID;Name;Parent


# Alineamientos

Mapear las letras (bases) de dos o más secuencias, permitieando algunos espaciadores (indels). 

Variaciones:
Indels
Substituciones


El ADN se alinea de forma continua al genoma

Pero el mRNA puede tener un alineameinto dividido (spliced aligment) -> <- y forman un continuo


## NGS alignments

* Concordantes: apareados apropiadamente (properly paired)
* No concordantes: si no están apropiadamente 

### Formato SAM/BAM

Formato para representar un alineamiento de NGS seq

Header: líneas que empiezan con @ y dan información del aliamiento, la longitud de cada chromosoma, programa con el que se hizo, etc.

Alineamiento: una línea por cada alineamiento.

Read id
FLAG: en formato binario, brinda info sobre la secuencia (paired, proper pair, mapped, mate maped, forward, mate reverse, passed quality check, not PCR duplicate, etc(.
Chr
Start
Mapping quality
CIGAR (aligment): indica si es un match, indel, intron (region que se salta), soft clipping, hardclipping, paddin, mismatch. 
Mate chr
Mate start
Mate dist
Query seq
Query base quals
Alignment score
Edot distance to reference
Number of hits
Strand
Hit index for this alignment


# Extracción de info de secuencias con comandos Unix


* Obtener secuencia FASTA de un gen x organismo tal.
 Ir a NCBI, buscar en Nucleotide dar formato Fasta

* Obtener datos FASTQ
Ir a NCBI buscar en SRA
Click lleva a la página del experimento, la corrida, el número de bases, etc. 
Click on reads nos lleva a ver un read
En la página de download hay un link... se puede bajar desde ahí, o mejor aún desde la línea de comando.

"Downloading SRA data using the SRA Toolkit"

wget 
Baja los datos de una dirección de internet

head archivo.sra

fasta-dump para abrir archivo sra 


nohup comando para correr en el background



## UCSC 

Table browser to download the features
Output format BED o lo que queramos-


# SAMtools

flagstat
sort
index
merge
view


Para saber cuántos alineamientos hay en un bam
samtools flagstat example.bam 

Para ordenar (útil para visualización)
samtools sort example.bam

nohup samtools sort example.bab example.sorted & #para correr en el background. El & es necesario.

Para ver el resultado:
samtools index example.sortes.bam

Creará un *.bai, que es el archivo ya indexado.


zcat view content without unzipping


samtools merge ejemploind1.bam ejemploind2.bam ejemploind2.bam

Ver un alineamiento:
samtools view 


























