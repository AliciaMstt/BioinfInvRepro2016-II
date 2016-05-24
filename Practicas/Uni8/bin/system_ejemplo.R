# obtener wd
system("pwd")

# enlistar archivos
system("ls")

# crear carpeta
system("mkdir Test")

# checar
system("ls")

# ver ayuda vcf
system("vcftools")

#escribir datos
x<-1:100
x
write(x, file="Test/x.txt")

# borrar carpeta
system("rm -r Test")
