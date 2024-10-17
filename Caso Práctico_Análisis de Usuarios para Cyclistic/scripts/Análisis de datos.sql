-- Análisis de Datos
-- Análisis descriptivo

-- 1. Distribución de viajes por tipo de usuario (miembros vs casuales)
with viajes_por_tipo_usuario as (
select member_casual,  count(*) as total_trips_by_member_casual
from public._202309_to_202408_divvy_tripdata
group by member_casual)
select member_casual,total_trips_by_member_casual,sum(total_trips_by_member_casual) over() as total_trips,(total_trips_by_member_casual/sum(total_trips_by_member_casual) over())as contribution_by_type
from viajes_por_tipo_usuario
/*Nota: En la distribución de viajes existe una mayor proporción en los que son miembros anuales con 
64,108%, mientras que los usuarios ocasionales representan el 35,892% de los viajes.*/
-- 2. Distribución de la duración de los viajes por tipo de usuario
select member_casual,  avg(ride_length) as avg_ride_length,
max(ride_length) as max_ride_length
from public._202309_to_202408_divvy_tripdata
group by member_casual
/*Nota: En promedio los usuarios ocasionales presentan una mayor duración en los viajes, con una duración
promedio de 25,78 minutos por viaje, los miembros anuales presentan una duración promedio de 12,95 
minutos por viaje. la duración máxima para ambos tipos de usuario alcanza hasta un valor de 1560 minutos
aproximadamente.*/
-- 3. Promedio de la duración de los viajes por tipo de usuario y por día de la semana
select member_casual, day_of_week, avg(ride_length) as avg_ride_length
from public._202309_to_202408_divvy_tripdata
group by member_casual,day_of_week
order by avg(ride_length) desc
/*Nota: Tanto miembros anuales como usuarios ocasionales en general tienden a tener una mayor duración
en los viajes el sabado y domingo,mientras que los días martes y jueves es cuando menor promedio de duración tienen
los usuarios ocasionales, para el caso de los miembros anuales sería los días lunes y jueves.*/
-- 4. Análisis por día de la semana
select member_casual,day_of_week, count(*) as total_trips
from public._202309_to_202408_divvy_tripdata
group by member_casual, day_of_week
order by total_trips desc
/*Nota: los miembros anuales en general presentan mayor cantidad de viajes duante la semana de lunes a
viernes con una tendencia creciente hasta el día miercoles, mientras que en los usuarios ocasionales suelen haber
más viajes los sábados y domingos, caso contrario  de los miembros anuales que poseen la menor cantidad 
de viajes los fines de semana, en el caso de los usuarios ocasionales la menor cantidad de viajes se 
da los días lunes y martes y se tiene una tendecia creciente hasta el día sábado.*/
select day_of_week,count(day_of_week) as mode_
from public._202309_to_202408_divvy_tripdata
group by day_of_week
order by mode_ desc
limit 1
/*Nota: En general el día sábado es cuando mas frecuencia de viajes hay.*/
-- 5. Distribución por hora del día

select member_casual,day_of_week,extract(hour from started_at) as hour_of_day, count(*) as total_trips
from public._202309_to_202408_divvy_tripdata
group by member_casual,day_of_week,hour_of_day
order by total_trips desc

/*Nota: Para los miembros anuales las horas de mas uso de las bicicletas son de 12 p.m. a 6 p.m.
siendo las 5 p.m. donde mas viajes hay en general, en horas de la mañana la mayor cantidad de viajes
se da a las 8 a.m.. En el caso de miembros ocasionales existe un comportamiento similar en horas de
la tarde, pero en horas de la mañana tiende haber mas viajes a las 11 a.m.. */

-- 6. Segmentación temporal de uso (meses o temporadas)

select member_casual, extract(month from started_at) as month,extract(year from started_at) as year, count(*) as total_trips
from public._202309_to_202408_divvy_tripdata
group by member_casual,year, month,year
order by year desc, month desc;
/*Nota: visto desde el punto de vista de mes los viajes de los miembros anuales presentan un 
comportamiento creciente a lo largo del año 2024 hasta agosto, misma situación ocurre con los
usuarios ocasionales con la diferencia de que el punto máximo lo alcanza en julio y posteriormente
en agosto disminuye. En el caso del año 2023 el comportamiento va decreciente desde septiembre a diciembre
tanto para miembros anuales como para usuarios ocasionales.