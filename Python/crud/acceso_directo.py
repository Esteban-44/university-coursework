# Definir los anchos del registro de longitud fija
def contruir_registro(activo, id, titulo, autor, duracion, anio, genero):
    return (
        str(activo).ljust(1) +
        str(id).zfill(4) +
        titulo[:30].ljust(30) +
        autor[:20].ljust(20) +
        str(duracion).zfill(5) +
        str(anio).zfill(4) +
        genero[:10].ljust(10) +
        "\n"
    )

REGISTRO_LEN = 75

# Prepara el archivo de almacenamiento
with open("canciones_directo.txt", "a", encoding="utf-8") as archivo:
    pass

# Escritura directa en el archivo
def agregar_directo(id, titulo, autor, duracion, anio, genero):
    registro = contruir_registro(1, id, titulo, autor, duracion, anio, genero)
    with open("canciones_directo.txt", "r+", encoding="utf-8") as archivo:
        archivo.seek((id - 1) * REGISTRO_LEN)
        archivo.write(registro)

agregar_directo(1, "La vaca lola", "Varios", 420, 2005, "Infantil")
agregar_directo(2, "La serpiente", "Anonimo", 355, 2000, "Variada")
agregar_directo(3, "El pescador", "Antiguo", 250, 1940, "Popular")


def leer_directa(id):
    with open("canciones_directo.txt", "r", encoding="utf-8") as archivo:
        archivo.seek((id - 1) * REGISTRO_LEN)
        registro = archivo.read(REGISTRO_LEN)
        activo = registro[0:1]
        if activo == "0":
            print(f"Registro {id}: ELIMINADO")
            return
        titulo = registro[5:35].strip()
        autor = registro[35:55].strip()
        duracion = registro[55:60].strip()
        anio = registro[60:64]
        genero = registro[64:74]

        print(titulo, " - ", autor, anio)


# Actualizar archivo directo
def actualizar_directo(id, titulo):
    with open("canciones_directo.txt", "r+", encoding="utf-8") as archivo:
        archivo.seek((id - 1) * REGISTRO_LEN)
        registro = archivo.read(REGISTRO_LEN)
        activo = registro[0:1]
        autor = registro[35:55].strip()
        duracion = registro[55:60].strip()
        anio = registro[60:64]
        genero = registro[64:74]

        nuevo_registro = contruir_registro(
            activo, id, titulo, autor, duracion, anio, genero
        )

        archivo.seek((id - 1) * REGISTRO_LEN)
        archivo.write(nuevo_registro)

actualizar_directo(1, "Pin pon")
leer_directa(1)


# Eliminar directo - archivos
def eliminar_directo(id):
    with open("canciones_directo.txt", "r+", encoding="utf-8") as archivo:
        archivo.seek((id - 1) * REGISTRO_LEN)
        archivo.write("0")

eliminar_directo(2)
leer_directa(2)