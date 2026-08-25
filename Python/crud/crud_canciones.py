#Prueba inicial:abrir,leer,editar,eliminar y cerrar un archivo
with open("canciones.txt","a",encoding="utf-8") as archivo:
    archivo.write("1, Bohemian Rhapsody, Rock, 1975, Queen\n")

#Implementar la funcion de creacion
def agregar_cancion(id,titulo,genero,artista,anio,autor,duracion):
    with open("canciones.txt", "a",encoding="utf-8") as archivo:
        linea = f"{id},{titulo},{genero},{artista},{anio},{autor},{duracion}\n"
        archivo.write(linea)
 
#Datos de prueba
agregar_cancion(2,"Imagine","Romantic","John Lennon",1971,"John Lennon",500)
 
#Implementar la funcion de lectura
def listar_canciones():
    with open("canciones.txt", "r",encoding="utf-8") as archivo:
        for linea in archivo:
            campos = linea.strip().split(",")
            print(campos)
listar_canciones()
 
#Implementar la funcion de actualizar
def actualizar_cancion(id_buscado, nuevo_titulo):
    lineas_nuevas = []
    with open("canciones.txt", "r", encoding="utf-8") as archivo:
        for linea in archivo:
            campos = linea.strip().split(",")
            if campos[0] == str(id_buscado):
                campos[1] = nuevo_titulo
            lineas_nuevas.append(",".join(campos) + "\n")

    with open("canciones.txt", "w", encoding="utf-8") as archivo:
        for linea in lineas_nuevas:
            archivo.write(linea) 
 
actualizar_cancion(2, "Cambio de titulo")
 
#Implementar la funcion de eliminacion
def eliminar_cancion(id_buscado):
    lineas_nuevas = []
    with open("canciones.txt", "r", encoding="utf-8") as archivo:
        for linea in archivo:
            campos = linea.strip().split(",")
            if campos[0] != str(id_buscado):
                lineas_nuevas.append(linea.strip())
 
    with open("canciones.txt", "w", encoding="utf-8") as archivo:
        for linea in lineas_nuevas:
            archivo.write(linea + "\n")
 
eliminar_cancion(2)