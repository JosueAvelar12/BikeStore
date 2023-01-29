CREATE DATABASE BikeStores_Datamart
GO

USE BikeStores_Datamart
GO

CREATE TABLE Productos(
	id_producto int not null identity(1,1) primary key,
	nombre varchar(255),
	marca varchar(255),
	categoria varchar(255),
	precioUnitario decimal
);
CREATE TABLE Clientes(
	id_cliente int not null identity(1,1) primary key,
	nombre varchar(550),
	estado varchar(255)
);
CREATE TABLE Empleados(
	id_empleado int not null identity(1,1) primary key,
	nombre varchar(550),
	estado tinyint
	--id_jefe int
	--FOREIGN KEY (id_jefe) 
    --REFERENCES Empleados (id_empleado)
);
CREATE TABLE Tiendas(
	id_tienda int not null identity(1,1) primary key,
	nombre varchar(255),
	ciudad varchar(255),
	estado varchar(255)
);
CREATE TABLE Tiempo(
	id_tiempo int not null identity(1,1) primary key,
	fecha_envio date,
	anio int,
	trimestre int,
	mes int,
	dia int
);
CREATE TABLE Pedidos(
	id_producto int not null foreign key references Productos(id_producto),
	id_cliente int not null foreign key references Clientes(id_cliente),
	id_empleado int not null foreign key references Empleados(id_empleado),
	id_tienda int not null foreign key references Tiendas(id_tienda),
	id_tiempo int not null foreign key references Tiempo(id_tiempo),
	precio_total decimal
);
