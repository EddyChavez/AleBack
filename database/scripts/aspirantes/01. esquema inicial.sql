use SWIITL;

/*********************  INICIO MODIFICACIONES LUNES 15 DE ABRIL 2019 *********************************
 * CONTROL DE CAMBIOS EN AMBIENTES
 * LOCAL:      PENDIENTE (FECHA DE APLICACIÓN)
 * PRUEBAS:    PENDIENTE (FECHA DE APLICACIÓN)
 * PRODUCCIÓN: PENDIENTE (FECHA DE APLICACIÓN)
*/
-- AQUÍ SE INDICAN TODOS LOS CAMBIOS QUE SE HAGAN DURANTE EL DÍA O RANGO DE FECHAS

-- SCRIPT INICIAL PARA LAS TABLAS DEL ESQUEMA TECNOLÓGICO

--Tabla para almacenar el turno en que pueden tomar el examen

ALTER TABLE CATR_CARRERA ADD CLAVE_CARRERA VARCHAR(255);

CREATE TABLE CATR_REFERENCIA_BANCARIA_USUARIO(
    PK_REFERENCIA_BANCARIA_USER INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FK_USUARIO INT NOT NULL FOREIGN KEY REFERENCES users(PK_USUARIO),
    REFERENCIA_BANCO VARCHAR(255) NOT NULL,
    MONTO NUMERIC NOT NULL,
    CONCEPTO VARCHAR(255) NOT NULL,
    CANTIDAD INT NOT NULL,
    TIPO_PAGO VARCHAR(255) NOT NULL,
    FECHA_PAGO DATE NOT NULL,
    FECHA_LIMIE DATE NOT NULL,
    FK_USUARIO_REGISTRO INT NULL,
	FECHA_REGISTRO DATETIME NOT NULL DEFAULT GETDATE(),
	FK_USUARIO_MODIFICACION INT NULL,
	FECHA_MODIFICACION DATETIME NULL,
    BORRADO NCHAR(1) NOT NULL DEFAULT 0
);

CREATE TABLE CAT_TURNO(
    PK_TURNO      INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DIA           date,
    HORA          VARCHAR(15),
    FK_USUARIO_REGISTRO INT NULL,
	FECHA_REGISTRO DATETIME NOT NULL DEFAULT GETDATE(),
	FK_USUARIO_MODIFICACION INT NULL,
	FECHA_MODIFICACION DATETIME NULL,
    BORRADO NCHAR(1) NOT NULL DEFAULT 0
);

ALTER TABLE CAT_TURNO ADD CONSTRAINT DIA_HORA  UNIQUE(DIA,HORA);


-- Catálogo que almacena los tipos de espacios
CREATE TABLE CAT_TIPO_ESPACIO(
  PK_TIPO_ESPACIO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  NOMBRE VARCHAR (100) NOT NULL,
    FK_USUARIO_REGISTRO INT NULL,
	FECHA_REGISTRO DATETIME NOT NULL DEFAULT GETDATE(),
	FK_USUARIO_MODIFICACION INT NULL,
	FECHA_MODIFICACION DATETIME NULL,
    BORRADO NCHAR(1) NOT NULL DEFAULT 0
);

--Catálogo que almacena el Tecnológico
CREATE TABLE CAT_TECNM (
  PK_TECNM INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  NOMBRE VARCHAR (100) NOT NULL,
    FK_USUARIO_REGISTRO INT NULL,
	FECHA_REGISTRO DATETIME NOT NULL DEFAULT GETDATE(),
	FK_USUARIO_MODIFICACION INT NULL,
	FECHA_MODIFICACION DATETIME NULL,
    BORRADO NCHAR(1) NOT NULL DEFAULT 0
);

-- Catálogo que almacena los campus
CREATE TABLE CAT_CAMPUS (
  PK_CAMPUS INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  NOMBRE VARCHAR (100) NOT NULL,
  FK_TECNM INT,
  FOREIGN KEY (FK_TECNM) REFERENCES CAT_TECNM(PK_TECNM),
    FK_USUARIO_REGISTRO INT NULL,
	FECHA_REGISTRO DATETIME NOT NULL DEFAULT GETDATE(),
	FK_USUARIO_MODIFICACION INT NULL,
	FECHA_MODIFICACION DATETIME NULL,
    BORRADO NCHAR(1) NOT NULL DEFAULT 0
);

-- Tabla para almacenar: NOMBRE del edificio, PREFIJO del edificio. 
CREATE TABLE CATR_EDIFICIO(
  PK_EDIFICIO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  FK_CAMPUS INT,
  NOMBRE VARCHAR (100) NULL,
  PREFIJO VARCHAR (100)NOT NULL,
  FOREIGN KEY (FK_CAMPUS) REFERENCES CAT_CAMPUS(PK_CAMPUS),
    FK_USUARIO_REGISTRO INT NULL,
	FECHA_REGISTRO DATETIME NOT NULL DEFAULT GETDATE(),
	FK_USUARIO_MODIFICACION INT NULL,
	FECHA_MODIFICACION DATETIME NULL,
    BORRADO NCHAR(1) NOT NULL DEFAULT 0
);

-- Tabla para almacenar el espacio, NOMBRE y tipo, en referencia al edificio y su IDENTIFICADOR.
CREATE TABLE CATR_ESPACIO(
  PK_ESPACIO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  FK_EDIFICIO INT,
  FK_TIPO_ESPACIO INT,
  NOMBRE VARCHAR(100),
  IDENTIFICADOR VARCHAR (50),
  CAPACIDAD INT,
  FOREIGN KEY (FK_EDIFICIO) REFERENCES CATR_EDIFICIO(PK_EDIFICIO),
  FOREIGN KEY (FK_TIPO_ESPACIO) REFERENCES CAT_TIPO_ESPACIO(PK_TIPO_ESPACIO),
    FK_USUARIO_REGISTRO INT NULL,
	FECHA_REGISTRO DATETIME NOT NULL DEFAULT GETDATE(),
	FK_USUARIO_MODIFICACION INT NULL,
	FECHA_MODIFICACION DATETIME NULL,
    BORRADO NCHAR(1) NOT NULL DEFAULT 0
);

ALTER TABLE CATR_ESPACIO ADD CONSTRAINT NOMBRE_IDENTIFICADOR  UNIQUE(NOMBRE,IDENTIFICADOR);

--Tabla para traer datos del día, HORA y aula
CREATE TABLE CATR_EXAMEN_ADMISION(
    PK_EXAMEN_ADMISION  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FK_ESPACIO          INT,
    FK_TURNO            INT,
    LUGARES_OCUPADOS    INT,
    FOREIGN KEY (FK_ESPACIO) REFERENCES CATR_ESPACIO(PK_ESPACIO),
    FOREIGN KEY (FK_TURNO) REFERENCES CAT_TURNO(PK_TURNO),
    FK_USUARIO_REGISTRO INT NULL,
	FECHA_REGISTRO DATETIME NOT NULL DEFAULT GETDATE(),
	FK_USUARIO_MODIFICACION INT NULL,
	FECHA_MODIFICACION DATETIME NULL,
    BORRADO NCHAR(1) NOT NULL DEFAULT 0
);

ALTER TABLE CATR_EXAMEN_ADMISION ADD CONSTRAINT ESPACIO_TURNO  UNIQUE(FK_ESPACIO,FK_TURNO);

--Creación de columna para relacionar datos de ficha de alumno con su lugar de examen
ALTER TABLE CATR_ASPIRANTE
  ADD FK_EXAMEN_ADMISION INT;
ALTER TABLE CATR_ASPIRANTE
  ADD CONSTRAINT foreign_examen FOREIGN KEY(FK_EXAMEN_ADMISION) REFERENCES CATR_EXAMEN_ADMISION(PK_EXAMEN_ADMISION);


/*********************  FIN MODIFICACIONES (RANGO DE FECHA O DÍA) (EJEMPLO LUNES 8 DE ABRIL) *********************************/

-- --------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------
