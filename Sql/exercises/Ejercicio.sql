CREATE DATABASE Tienda;
USE Tienda;
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Clientes (
IdCliente INT NOT NULL,
Nombre VARCHAR(30),
Telefono INT,
Correo VARCHAR(30),
ComprasTotales INT,
PRIMARY KEY (IdCliente)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Empleados (
IdEmpleado INT NOT NULL,
Cargo VARCHAR(30),
Nombre VARCHAR(30),
Telefono INT,
Correo VARCHAR(30),
Salario DOUBLE,
PRIMARY KEY (IdEmpleado)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Proveedores (
IdProveedor INT NOT NULL,
Nombre VARCHAR(30),
Dirección VARCHAR(30),
Telefono INT,
PRIMARY KEY (IdProveedor)
);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE Productos (
IdProducto INT NOT NULL,
Nombre VARCHAR(30),
Precio DOUBLE,
FechaExp DATE,
FechaVen DATE,
IdProveedor INT NOT NULL,
Stock INT,
PRIMARY KEY (IDProducto),
FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor)
);
-----------------------------------------------------------------------------------------------------------------
INSERT INTO Clientes (IdCliente, Nombre, Telefono, Correo, ComprasTotales) VALUES
(001, 'Juan Perez', 300123456, 'juan@gmail.com', 2),
(002, 'Maria Gomez', 301234567, 'maria@gmail.com', 11),
(003, 'Carlos Ruiz', 302345678, 'carlos@gmail.com', 6);

INSERT INTO Clientes (IdCliente, Nombre, Telefono, Correo, ComprasTotales) VALUES
(004, 'Santiago diaz', NULL, 'diaz@gmail.com', 3);

INSERT INTO Clientes (IdCliente, Nombre, Telefono, Correo, ComprasTotales) VALUES
(005, 'Alberto Lopez', NULL, 'diaz@gmail.com', 5);

INSERT INTO Clientes (IdCliente, Nombre, Telefono, Correo, ComprasTotales) VALUES
(006, 'LINA MARTINEZ', 334254235, 'lina@gmail.com', 5);
SELECT * FROM Clientes;

ALTER TABLE Clientes
ADD NivelCliente INT;

ALTER TABLE Clientes
ADD ComprasTotales INT;
-----------------------------------------------------------------------------------------------------------------
INSERT INTO Empleados (IdEmpleado, Cargo, Nombre, Telefono, Correo, Salario) VALUES
(432, 'Gerente', 'Laura Ramirez', 310456789, 'laura.martinez@gmail.com', 4500000),
(321, 'Domicilio', 'Andrés Martinez', 311567890, 'andres.ramirez@gmail.com', 2200000),
(123, 'Cajero', 'Sofía Herrera', 312678901, 'sofia.herrera@gmail.com', 2300000);
SELECT * FROM Empleados;
-----------------------------------------------------------------------------------------------------------------
INSERT INTO Proveedores (IdProveedor, Nombre, Dirección, Telefono) VALUES
(1001, 'Frutas del Valle', 'Cali', 334312456),
(1011, 'Agricola la Esperanza', 'Medellín', 311234567),
(1010, 'Campo Fresco', 'Bogotá', 322345678);
SELECT * FROM proveedores;
-----------------------------------------------------------------------------------------------------------------
INSERT INTO Productos (IdProducto, Nombre, Precio, FechaExp, FechaVen, IdProveedor, Stock) VALUES
(64334212, 'Manzana', 2500, '2025-08-01', '2025-08-20', 1001, FALSE),
(55212351, 'Banana', 1800, '2025-08-02', '2025-08-12', 1011, TRUE),
(63231573, 'Naranja', 2200, '2025-08-03', '2025-08-18', 1010, TRUE),
(49525271, 'Pera', 3000, '2025-08-04', '2025-08-22', 1001, FALSE),
(25461215, 'Uvas', 4500, '2025-08-05', '2025-08-15', 1011, FALSE);
SELECT * FROM Productos;

ALTER TABLE Productos
ADD Stock BOOLEAN;
-----------------------------------------------------------------------------------------------------------------
UPDATE Clientes
SET Telefono = '365432121'
WHERE IdCliente = 1;

DELETE FROM Productos
WHERE IdProducto = '64334212';

UPDATE Productos
SET Precio = ROUND(Precio * 1.15, 2)
WHERE IdProducto;

SELECT IdCliente, ComprasTotales,
  CASE
    WHEN ComprasTotales > 10 THEN 'Premium'
    WHEN ComprasTotales BETWEEN 5 AND 10 THEN 'Frecuente'
    ELSE 'Nuevo'
  END AS NivelCliente
FROM Clientes;

SELECT IdEmpleado, Nombre, Salario
FROM Empleados
WHERE Salario > (SELECT AVG(Salario) FROM Empleados);

ALTER TABLE Empleados
ADD CONSTRAINT CheckSalario CHECK (Salario > 0);

ALTER TABLE Empleados  
ADD CONSTRAINT uq_email UNIQUE (Correo);

UPDATE Proveedores
SET Nombre = UPPER(TRIM(Nombre)),
    Dirección = UPPER(TRIM(Dirección));
    
UPDATE Productos  
SET Stock = Stock - 12  
WHERE IdProducto = 101 AND Stock >= 12; 
-----------------------------------------------------------------------------------------------------------------
SELECT Nombre, Precio
FROM Productos
WHERE Precio < 3000;

SELECT * FROM Productos
WHERE Precio < 6000 AND STOCK = TRUE;

SELECT * FROM Productos
WHERE Precio < 6000 OR STOCK = TRUE;

SELECT * FROM Productos
WHERE NOT Precio > 3000;

SELECT * FROM Productos WHERE Precio BETWEEN 500 AND 3000;

SELECT Nombre FROM Clientes WHERE Telefono IS NULL;

SELECT Nombre, COALESCE(Telefono, 'Sin Registro') AS Telefono FROM Clientes;

SELECT DISTINCT Correo FROM Clientes;

SELECT LOWER(TRIM(Nombre)) AS Nombre FROM Clientes;

SELECT Productos.Nombre, Proveedores.Nombre
FROM Productos
INNER JOIN Proveedores ON Productos.IdProveedor = Proveedores.IdProveedor;

SELECT Productos.Nombre, Proveedores.Nombre
FROM Productos
LEFT JOIN Proveedores ON Productos.IdProveedor = Proveedores.IdProveedor;

SELECT Productos.Nombre, Proveedores.Nombre
FROM Productos
RIGHT JOIN Proveedores ON Productos.IdProveedor = Proveedores.IdProveedor;

SELECT Productos.Nombre, Proveedores.Nombre
FROM Productos
INNER JOIN Proveedores ON Productos.IdProveedor = Proveedores.IdProveedor
WHERE Proveedores.Nombre = 'Agricola la Esperanza';

SELECT Productos.Nombre, Proveedores.Nombre
FROM Productos
INNER JOIN Proveedores ON Productos.IdProveedor = Proveedores.IdProveedor
WHERE Proveedores.Nombre = 'Agricola la Esperanza';

SELECT Prd.Nombre, Prv.Nombre
FROM Productos AS Prd
INNER JOIN Proveedores AS Prv ON Prd.IdProveedor = Prv.IdProveedor;

SELECT Productos.Nombre, COUNT(Productos.IdProducto) AS TotalPrd
FROM Productos
LEFT JOIN Proveedores ON Productos.IdProveedor = Proveedores.IdProveedor
GROUP BY Productos.Nombre;