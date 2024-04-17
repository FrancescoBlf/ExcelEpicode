-- ESERCIZIO 1 ******************************************************************************************************************************************* --
-- Cominciate facendo un’analisi esplorativa del database, ad esempio: Fate un elenco di tutte le tabelle. Visualizzate le prime 10 righe della tabella Album.
-- Trovate il numero totale di canzoni della tabella Tracks. Trovate i diversi generi presenti nella tabella Genre
-- *********************************************************************************************************************************************************** --
use chinook;

select * from album; -- esplorazione integrata con diagramma E/R tramite Reverse Enginer
select * from artist;
select * from customer;
select * from employee;
select * from genre;
select * from invoice;
select * from invoiceline;
select * from mediatype;
select * from playlist;
select* from playlisttrack;
select * from track;

-- ESERCIZIO 2
-- Recuperate il nome di tutte le tracce e del genere associato.

select t.Name
       ,g.name
from track as t 
inner join genre as g 
on t.genreID = g.genreID;

-- ESERCIZIO 3
-- Recuperate il nome di tutti gli artisti che hanno almeno un album nel database. Esistono artisti senza album nel database?

select  al.Title
	   ,ar.Name
from artist  as ar
left join album as al 
on ar.ArtistId = al.ArtistId
where al.artistID is not null;

select  al.Title          -- questa query è per rispondere alla seconda domanda. Si, ci sono artisti senza album.
	   ,ar.Name
from artist  as ar
left join album as al 
on ar.ArtistId = al.ArtistId
where al.artistID is null;

-- ESERCIZIO 4
-- Recuperate il nome di tutte le tracce, del genere associato e della tipologia di media. Esiste un modo per recuperare il nome della tipologia di media?

select  t.Name
	   ,g.Name
       ,m.Name
from genre as g
inner join track as t
on g.GenreId = t.GenreId
inner join mediatype as m
on m.MediaTypeId = t.MediaTypeId;

-- ESERCIZIO 5
-- Elencate i nomi di tutti gli artisti e dei loro album.

select ar.Name
	  ,al.Title
from artist as ar
inner join album as al
on al.ArtistId = ar.ArtistId;