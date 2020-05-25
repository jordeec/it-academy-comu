
/**
* Creació d'usuari
*/

-- En l'enunciat l'usuari creat (createUser.sql) s'autoritza en una BD que no té el mateix nom que la que es crea
-- a l'script (createUSFlightsSchema.sql). No té importància si l'exercici es resol fent les queries amb l'usuari
-- root en comptes de testUser/123

-- 
/**
* Creació de taules
*/

-- L'script penjat a l'enunciat no conté totes les columnes necessàries per a poder fer la importació, he modificat
-- el fitxer createUSFlightsSchema.sql i afegir les definicions de les columnes que mancaven però aleshores no podia
-- fer la importació correctament per errors de FK. He tornat als fitxers originals.

/**
* Importació de taules
*/

-- a) L' ordre correcte d'importació és: USAirports, Carriers i Flights perquè la tercera taula té dues FKs
-- cap a les primeres

-- b) No, no ho estan i no entenc perquè. Podria ser que l'exportació fos d'una base de dades diferent per a la
-- taula flights que de les dues taules de companyies i aeroports.

/**
* 1. Quantitat de registres de la taula de vols:
*/

select count(*) from flights;

/**
* 2. Retard promig de sortida i arribada segons l’aeroport origen.
*/
select Origin, avg(ArrDelay) as prom_arribades, avg(DepDelay) as prom_sortides
from flights
group by origin;
--

/**
* 3. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen. 
  A més, volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre de les files)
*/

select Origin, colYear, colMonth, format(avg(ArrDelay) , 4) as prom_arribades
from flights
group by origin, colYear, colMonth 
order by Origin, colYear asc, colMonth asc;

/**
* 4. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen (mateixa consulta 
 que abans i amb el mateix ordre). Però a més, ara volen que en comptes del codi de l’aeroport es mostri 
 el nom de la ciutat.
*/

select a.City, colYear, colMonth, format(avg(ArrDelay) , 4) as prom_arribades
from flights f join usairports a on f.Origin = a.iata
group by origin, colYear, colMonth 
order by Origin, colYear asc, colMonth asc;

/**
* 5. Les companyies amb més vols cancelats, per mesos i any. A més, han d’estar ordenades de forma que les 
  companyies amb més cancel·lacions apareguin les primeres.
*/

select UniqueCarrier, colYear, colMonth, count(cancelled) as total_cancelled 
From flights f where Cancelled = true
group by UniqueCarrier, colYear, colMonth
order by total_cancelled desc, colYear asc, colMonth asc;

/**
* 6. L’identificador dels 10 avions que més distància han recorregut fent vols.
*/


select TailNum, sum(Distance)
from flights
where TailNum is not null -- Perquè no discrimina els nulls ?
group by TailNum
order by 2 desc

/**
* 7. Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben al seu destí amb 
  un retràs promig major de 10 minuts.
*/

select UniqueCarrier,  avg(ArrDelay) as avgDelay
From flights f 
GROUP by UniqueCarrier
having avg(ArrDelay) > 10
order by 2 desc

