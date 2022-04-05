# RCRA-UNBLOCK
Desarrollo de pograma en Telingo que resuelve el puzzle 'Unblock'

# Encoder
Se ha creado un programa en python el cual lee un txt con la disposición de los bloques y los codifica al lenguaje ASP.

# Ejecucion
Para obtener y mostrar el resultado del puzzle a través de pygame, es necesario ejecutar estos tres comandos.
```
python3 encode.py ./examples/level1.txt level1.lp
telingo --verbose=0 --warn none unblock.lp level1.lp > sol1.txt
python3 showunblock.py ./examples/level1.txt sol1.txt
```
# Autores
Arturo Ramos Rey
Adriano Miranda Seoane 

