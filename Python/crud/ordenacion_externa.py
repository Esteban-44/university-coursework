def agregar_cancion(id, titulo, artista, genero, anio, duracion):
    with open ("Canciones_usando.txt","a", encoding= "utf-8") as archivo:
        archivo.write(f"0,{id},{titulo},{artista},{genero},{anio},{duracion},\n")
 
#contar registros
def contar_registros(archivo):
    total=0
    with open (archivo,"r", encoding="utf-8") as archivo_full:
        for _ in archivo_full:
            total +=1
    return total
 
#Buscar el minimo
def buscar_minimo_no_usado(archivo,indice_campo):
 
    minimo = None # no se cual es
    with open (archivo,"r", encoding="utf-8") as archivo_full:
        for linea in archivo_full:
            campos = linea.strip().split(",") # cambio de string a int
            if campos [0] == "1" : # si esta usado puede continnuar
                continue
 
            valor = int(campos[indice_campo])
            if minimo is None or valor < minimo [1]:
                minimo = (campos, valor)
 
    return minimo[0] if minimo is not None else None
 
def marcar_usado(archivo,id_registro):
    lineas_nuevas =[]
    with open (archivo,"r", encoding="utf-8") as archivo_full:  
        for linea in archivo_full:
            campos = linea.strip().split(",")
 
            if campos [1] == id_registro:
                campos [0] = "1"
            lineas_nuevas.append(",".join (campos))
 
    with open (archivo, "w", encoding = "utf-8") as archivo_full:
        for linea in lineas_nuevas:
            archivo_full.write(linea + "\n")
 
def ordenar_externa (archivo_entrada, archivo_salida, indice_campo):

    total = contar_registros (archivo_entrada)
    with open (archivo_salida, "w", encoding = "utf-8") as archivo_ordenado:
      
        for _ in range (total):
            registro = buscar_minimo_no_usado (archivo_entrada, indice_campo)
            if registro is None:          # <-- este cambio
                break
            archivo_ordenado.write(",".join(registro)+"\n")
            marcar_usado ( archivo_entrada, registro[1] )

if __name__ == "__main__":
    agregar_cancion (1,"Shape of You", "Ed Sheeran", "Pop", 2017, 353)
    agregar_cancion (2,"Besos Usados", "Andres Cepeda", "pop", 2019, 200)
    agregar_cancion (3,"La Camisa Negra", "Juanes", "Pop", 2005, 250)
 
    ordenar_externa ("Canciones_usando.txt", "Canciones_ordenadas.txt", 5)
 
    print ("Todo esta organizado ")