# Documentación del Proceso de Limpieza y Manipulación de Datos

/*El proceso se ejecuta en SQL con el objetivo de consolidar los datos de un año completo y prepararlos 
para el análisis de los comportamientos de usuarios. Se usa Sql que es una herramienta para procesar 
grandes volúmenes de datos, dado que al considerar la data de un año completo se encuentra un valor 
cercano a cinco millones setecientos mil registros. A continuación, se hace documentación de todas las
limpiezas y manipulaciones de datos.*/
## 1. Creación y Carga de Datos
### Objetivo
#### -Crear tablas para cada mes desde septiembre de 2023 a agosto de 2024. Se utiliza el nombre de la 
#### tabla _202408_divvy_tripdata como plantilla, cambiando el mes y año según corresponda. Se cargarán 
#### los datos de cada archivo CSV en su respectiva tabla.
-- Crear la tabla para almacenar los datos de trips
create table if not exists public._202408_divvy_tripdata
                 (ride_id      VARCHAR(255), rideable_type   VARCHAR(30), started_at     Timestamp
				  , ended_at      Timestamp, start_station_name VARCHAR(255), start_station_id   VARCHAR(255)
				  , end_station_name VARCHAR(255), end_station_id      VARCHAR(255), start_lat  decimal
				  , start_lng  decimal, end_lat   decimal, end_lng     decimal, member_casual VARCHAR(30));
-- Se procede a cargar datos desde el archivo csv a la tabla creada				 
copy public._202408_divvy_tripdata( ride_id, rideable_type, started_at, ended_at, start_station_name
								   , start_station_id, end_station_name, end_station_id, start_lat
								   , start_lng, end_lat, end_lng, member_casual )
from '/Program Files/PostgreSQL/16rc1/data/202408-divvy-tripdata.csv'
delimiter ','
csv header;   

### Nota: El código de creación y carga se repetirá para cada mes, cambiando el nombre de la tabla y 
### el archivo CSV correspondiente. El formato utilizado para la fecha sería el YYYY-MM-DD HH:MM:SS de Timestamp.


## 2. Consolidación de tablas 
### Objetivo
#### -Unir datos de múltiples tablas de trips en una tabla consolidada _202309_to_202408_divvy_tripdata.
-- Unir datos de varios meses en una sola tabla usando CTEs y UNION ALL
create table public._202309_to_202408_divvy_tripdata as

with _202309_to_202310_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual
from public._202309_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual										  										 
from public._202310_divvy_tripdata),
_202310_to_202311_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual
from _202309_to_202310_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual	
from public._202311_divvy_tripdata),
_202311_to_202312_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual
from _202310_to_202311_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
from public._202312_divvy_tripdata),
_202312_to_202401_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual
from _202311_to_202312_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
from public._202401_divvy_tripdata),
_202401_to_202402_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual
from _202312_to_202401_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
from public._202402_divvy_tripdata),
_202402_to_202403_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual
from _202401_to_202402_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
from public._202403_divvy_tripdata),
_202403_to_202404_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual 
from _202402_to_202403_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
from public._202404_divvy_tripdata),
_202404_to_202405_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual 
from _202403_to_202404_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual 
from public._202405_divvy_tripdata),
_202405_to_202406_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual 
from _202404_to_202405_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
from public._202406_divvy_tripdata),
_202406_to_202407_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual 
from _202405_to_202406_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual 
from public._202407_divvy_tripdata),
_202407_to_202408_divvy_tripdata as (select ride_id, rideable_type, started_at, ended_at, start_station_name
										 , start_station_id, end_station_name , end_station_id, start_lat, start_lng
										 , end_lat, end_lng, member_casual 
from _202406_to_202407_divvy_tripdata
union all
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name
, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual 
from public._202408_divvy_tripdata)
select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name 
                            ,end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual,
							extract(EPOCH from (ended_at - started_at)) / 60 as ride_length,
							(extract(DOW from started_at) + 1) as day_of_week
from _202407_to_202408_divvy_tripdata          
where (extract(EPOCH from (ended_at - started_at)) / 60)>0
order by started_at
### Nota: la tabla se ordena por la fecha de inicio de cada viaje y para garantizar consistencia en los 
tiempos se crean dos columnas denominadas “ride_length” y “day_of_week”. La primera calcula la 
diferencia entre la columna ended_at y started_at en minutos y con esta se filtra los resultados mayores a cero 
para garantizar que se cree una tabla con registros donde ride_length tiene valores positivos. La
columna day_of_week nos extrae de la fecha started_at el número de día de la semana en donde 1 es 
domingo y 7 es sábado.
-- Se crea una copia de respaldo de la tabla consolidada 
/*
create schema if not exists bkp;
create table bkp._202309_to_202408_divvy_tripdata_20240920 as
select * from public._202309_to_202408_divvy_tripdata
-- Restaurar la tabla original desde la tabla de respaldo si es necesario
drop table if exists public._202309_to_202408_divvy_tripdata

-- Restaura la tabla original desde la tabla de respaldo
create public._202309_to_202408_divvy_tripdata AS
select *
from bkp._202309_to_202408_divvy_tripdata_20240920 */
## 3. Limpieza de la tabla consolidada
### Objetivo
#### -Eliminar espacios en blanco en los valores de las columnas de tipo texto.
#### -Identificar y eliminar  duplicados.  
#### -Corregir inconsistencias en coordenadas de estaciones y rellenar valores nulos.
/* Eliminar espacios en blanco de cada una de las columnas de tipo texto o varchar para evitar errores 
en la comparación de strings */
update public._202309_to_202408_divvy_tripdata
set ride_id=trim(ride_id),
    rideable_type= trim(rideable_type),
	start_station_name=trim(start_station_name),
	start_station_id=trim(start_station_id),
	end_station_name=trim(end_station_name),
	end_station_id=trim(end_station_id),
	member_casual=trim(member_casual)

/* Se determina el nivel de agregación que consiste en encontrar combinaciónes unicas entre columnas
con el fin de identificar duplicados en la tabla */
select ride_id, count(*)
from public._202309_to_202408_divvy_tripdata
group by ride_id 
having count(*)>1
order by count(*) desc

/*Nota: Por el campo ride_id que sería el identificador de los viajes se encuentra que hay 209 duplicados.*/
/* Se procede a eliminar duplicados manteniendo solo el primer registro para evitar inconsistencias en
los viajes en cicla */
with duplicados_en_divy as(
 select *, ctid, row_number()over(partition by ride_id) as du
  from public._202309_to_202408_divvy_tripdata
  order by du asc)
 delete from public._202309_to_202408_divvy_tripdata
using duplicados_en_divy
where public._202309_to_202408_divvy_tripdata.ctid=duplicados_en_divy.ctid and duplicados_en_divy.du >1
/* Identificar valores nulos */
select
    count(*) filter (where ride_id is NULL) as nulos_ride_id,
	count(*) filter (where rideable_type is NULL) as nulos_rideable_type,
	count(*) filter (where started_at is NULL) as nulos_started_at,
	count(*) filter (where ended_at is NULL) as nulos_ended_at,
	count(*) filter (where start_station_id is NULL) as nulos_start_station_id,
    count(*) filter (where start_station_name is NULL) as nulos_start_station_name,
    count(*) filter (where start_lat is NULL) as nulos_start_lat,
    count(*) filter (where start_lng is NULL) as nulos_start_lng,
	count(*) filter (where end_station_id is NULL) as nulos_end_station_id,
    count(*) filter (where end_station_name is NULL) as nulos_end_station_name,
    count(*) filter (where end_lat is NULL) as nulos_end_lat,
    count(*) filter (where end_lng is NULL) as nulos_end_lng,
	count(*) filter (where member_casual is NULL) as nulos_member_casual
from public._202309_to_202408_divvy_tripdata;
/*Nota:Se encuentran datos nulos en las columnas de nombre de estación y Id de estación, al notar que no
hay datos nulos en las coordenadas de inicio y relativamente pocos nulos en las coordenadas de fin, se
decide rellenar los nombres de estación y id a partir de coordenadas de latitud y longitud.*/
/* Identificar si hay inconsistencias en las coordenadas de start_station_name y end_station_name */
 select 
      distinct start_station_name,start_lat,start_lng
    from 
        public._202309_to_202408_divvy_tripdata
	--where start_station_name is not  null
	order by start_station_name

	
 select 
      distinct end_station_name,end_lat,end_lng
    from 
        public._202309_to_202408_divvy_tripdata
	--where end_station_name is not null
	order by end_station_name,end_lat,end_lng
/* Corrección de Inconsistencias en Coordenadas para dejar una única coordenada por cada estación */	
with avg_coordinates1 as (
    select 
        start_station_name, 
        avg(start_lat) as avg_start_lat, 
        avg(start_lng) as avg_start_lng
    from 
        public._202309_to_202408_divvy_tripdata
	where start_station_name is not null
    group by 
        start_station_name
)
update 
    public._202309_to_202408_divvy_tripdata t
set 
    start_lat = ac.avg_start_lat,
    start_lng = ac.avg_start_lng
from 
    avg_coordinates1 ac
where 
    t.start_station_name = ac.start_station_name;

with avg_coordinates2 as (
    select 
        end_station_name, 
        avg(end_lat) as avg_end_lat, 
        avg(end_lng) as avg_end_lng
    from 
        public._202309_to_202408_divvy_tripdata
	where end_station_name is not null
    group by 
        end_station_name
)
update 
    public._202309_to_202408_divvy_tripdata t
set 
    end_lat = ac.avg_end_lat,
    end_lng = ac.avg_end_lng
from 
    avg_coordinates2 ac
where 
    t.end_station_name = ac.end_station_name;
/* Rellenar los valores nulos de start_station_name y start_station_id apartir de start_lat y start_lng */

with st_name_cord as (
    select 
        distinct start_station_name,start_station_id, 
        ROUND(start_lat, 2) as rounded_start_lat,  -- Renombramos las columnas redondeadas para mayor claridad
        ROUND(start_lng, 2) as rounded_start_lng
    from 
        public._202309_to_202408_divvy_tripdata
   
     where start_station_name is not NULL 
)
update 
    public._202309_to_202408_divvy_tripdata AS t
set 
    start_station_name = ac.start_station_name,
	start_station_id= ac.start_station_id
from 
    st_name_cord ac
where 
    ROUND(t.start_lat, 2) = ac.rounded_start_lat  -- Comparamos con las columnas redondeadas
    and ROUND(t.start_lng, 2) = ac.rounded_start_lng
    and t.start_station_name is NULL;  -- Solo actualiza si el nombre de la estación es NULL
/* Rellenar los valores nulos de end_station_name y end_station_id apartir de end_lat y end_lng */
with end_name_cord as (
    select 
        distinct end_station_name,end_station_id, 
        ROUND(end_lat, 2) as rounded_end_lat,  -- Renombramos las columnas redondeadas para mayor claridad
        ROUND(end_lng, 2) as rounded_end_lng
    from 
        public._202309_to_202408_divvy_tripdata
   
     where end_station_name is not NULL 
)
update 
    public._202309_to_202408_divvy_tripdata AS t
set 
    end_station_name = ac.end_station_name,
	end_station_id= ac.end_station_id
from 
    end_name_cord ac
where 
    ROUND(t.end_lat, 2) = ac.rounded_end_lat  -- Comparamos con las columnas redondeadas
    and ROUND(t.end_lng, 2) = ac.rounded_end_lng
    and t.end_station_name is NULL;  -- Solo actualiza si el nombre de la estación es NULL
/*Nota: Con el anterior procedimiento se lograr disminuir la cantidad de registros con datos nulos, 
pasando de una cantidad de aproximadamente un millón de registros a siete mil quinientos setenta con 
datos nulos, referente a valores duplicados se eliminan doscientos nueve registros de la tabla. Con lo anterior se 
en gran medida limpiar los datos para proceder a analizar.*/