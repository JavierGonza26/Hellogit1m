create database DB_CoffeesMedy
go
use DB_CoffeesMedy
go
 
create table Rol(
Id_Rol int primary key identity(1,1),
Tipo_Rol nvarchar(15) check (Tipo_Rol IN ('Admin', 'Cliente')) not null
)

create table Usuario (
Id_Usuario INT PRIMARY KEY IDENTITY(1,1),
Id_Rol int default 2 not null,
Nombre NVARCHAR(100) not null,
Email NVARCHAR(100) UNIQUE not null,
Contrasena NVARCHAR(100) not null,
TokenVerificacion NVARCHAR(100) NULL,
Verificado bit default 0
foreign key (Id_Rol) references Rol(Id_Rol)
)
go

ALTER TABLE Usuario
ADD TokenVerificacion NVARCHAR(100) NULL;
  alter table Usuario add Verificado bit default 0

CREATE TABLE Administrador(
  Id_admin INT Identity(1,1) NOT NULL PRIMARY KEY,
  Id_Usuario INT NOT NULL,
  FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

go

create table Imagen(
Id_Imagen int primary key identity(1,1),
Img_Url nvarchar(max) not null
)

CREATE TABLE Repartidor (
Id_Repartidor INT PRIMARY KEY IDENTITY(1,1),
Nombre NVARCHAR(100) NOT NULL,
Cedula CHAR(16) NOT NULL UNIQUE,  -- Ej: 001-260804-1023R
Fecha_Nacimiento AS ( CONVERT(DATE, '20' + RIGHT(SUBSTRING(Cedula, 5, 6), 2) + '-' +  SUBSTRING(Cedula, 7, 2) + '-' 
                    + SUBSTRING(Cedula, 5, 2))),
Edad AS (DATEDIFF(YEAR, CONVERT(DATE, '20' + RIGHT(SUBSTRING(Cedula, 5, 6), 2) + '-' + SUBSTRING(Cedula, 7, 2) + '-' 
        + SUBSTRING(Cedula, 5, 2)), GETDATE())),

Id_Imagen int not null,

foreign key (Id_Imagen) references Imagen(Id_Imagen)
)
go

CREATE TABLE Categoria (
Id_Categoria INT PRIMARY KEY IDENTITY(1,1),
Nombre NVARCHAR(50) NOT NULL UNIQUE
)
go

create table Producto(
Id_producto int primary key identity(1,1),
Nombre nvarchar(100) not null,
Precio decimal(10,2) not null,
Stock int not null,
Id_Imagen int not null,
Id_Categoria int not null,

foreign key (Id_Imagen) references Imagen(Id_Imagen),
foreign key (Id_Categoria) references Categoria(Id_Categoria)
)
go
