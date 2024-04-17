-- Esercizio 1 Recuperate tutte le tracce che abbiano come genere “Pop” o “Rock”

select t.name, g.name 
from track as t
inner join genre as g
on t.GenreId = g.GenreId
where g.name in ('Pop', 'Rock');

-- Esercizio 2 Elencate tutti gli artisti e/o gli album che inizino con la lettera “A”

select ar.name
	  ,al.Title
from artist as ar
inner join album as al
on ar.ArtistId = al.ArtistId
where ar.name   LIKE 'A%' and al.Title LIKE 'A%';

-- Esercizio 3 Elencate tutte le tracce che hanno come genere “Jazz” o che durano meno di 3 minuti.

select * 
from track as t
inner join genre as g 
on t.GenreId = g.GenreId
where g.name in ('Jazz')
or
t.Milliseconds < 180000;

-- Esercizio 4 Recuperate tutte le tracce più lunghe della durata media

SELECT 
    name,
    Milliseconds,
    (SELECT 
     AVG(Milliseconds)
	FROM track) AS AvgMilliseconds
FROM
    track
WHERE
    Milliseconds > (SELECT 
                    AVG(Milliseconds)
					FROM track);
                    
                    
-- Esercizio 5 Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti
    
  
 select g.Name, avg(Milliseconds) as media
 from track as t
 inner join genre as g 
 on t.GenreId = g.GenreId
 group by 
 g.name 
 having media >  240000;
 
-- Esercizio 6 Individuate gli artisti che hanno rilasciato più di un album.
 
 select               ar.name as Nome_Artista, 
		              count(al.title)
 from album as al
 inner join artist as ar
 on ar.ArtistId = al.ArtistId
 group by ar.Name
 order by count(al.title) DESC;
 
-- Esercizio 7 Trovate la traccia più lunga in ogni album.

 select              al.Title as Album,
                    concat(max(tr.Milliseconds),' ', 'Millisecondi') as Traccia_Massima
 from album as al
 inner join track as tr
 on al.AlbumId = tr.AlbumId
 group by al.Title;
 
 -- Esercizio 8 Individuate la durata media delle tracce per ogni album
 
  select              al.Title as Album,
					  round(avg(tr.Milliseconds),2) as Durata_media
 from album as al
 inner join track as tr
 on al.AlbumId = tr.AlbumId
 group by al.Title;
 
 -- Esercizio 9 Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in esso contenute.

 select          al.Title, 
                count(tr.Name) as Numero_Tracce
 from album as al 
 inner join track as tr
 on al.AlbumId = tr.AlbumId
 group by al.title 
 having count(tr.name) > 20;
 
                         
                       
 
 

