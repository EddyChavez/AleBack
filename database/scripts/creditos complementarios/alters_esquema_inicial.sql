/*cambios de la estructura de la bd*/

EXEC sp_RENAME 'ALUMNO_CREDITO.VALIDACION_1' , 'VALIDADO', 'COLUMN'

ALTER TABLE ACTIVIDADES ADD IMAGEN NVARCHAR(500);

ALTER TABLE ACTIVIDADES ALTER COLUMN DESCRIPCION NVARCHAR(1000);

ALTER TABLE ASISTENCIA_ALUMNO_ACTIVIDAD ADD UNIQUE(FK_ALUMNO_ACTIVIDAD)