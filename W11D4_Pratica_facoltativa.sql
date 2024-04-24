-- Esercizio 1 Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce.

select g.name,
	   count(t.TrackId) as Numero_tracce
from genre g
inner join track t
on g.GenreId = t.GenreId
group by g.name
having count(TrackId) > 10
order by Numero_tracce desc;


-- Esercizio 2 Trovate le tre canzoni più costose.

select 	t.name,
		sum(iv.Total) as TotaleVendutoDella_Traccia
from  invoice iv
inner join invoiceline i
on i.InvoiceId = iv.InvoiceId
inner join track t
on i.TrackId = t.TrackId
group by t.name
order by sum(iv.Total) desc
limit 3;

-- Esercizio 3 Elencate gli artisti che hanno canzoni più lunghe di 6 minuti.

select	sub.name, max(sub.Milliseconds)		
from( select ar.name, t.Milliseconds
from artist ar
inner join album al
on ar.ArtistId = al.ArtistId
inner join track t 
on al.AlbumId = t.AlbumId) as sub
group by sub.Name
having max(sub.Milliseconds) > 360000;

-- Esercizio 4 Individuate la durata media delle tracce per ogni genere

select  sub.name,
		avg(sub.Milliseconds) as MediaDurataDella_Traccia
from
	(select	g.name, t.Milliseconds
	from genre g
	inner join track t
	on g.GenreId = t.GenreId) as sub
    group by sub.name;

-- Esercizio 5 Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome.

select	g.name, t.Name
	from genre g
	inner join track t
	on g.GenreId = t.GenreId
    where t.name LIKE '%love%'
    order by g.name, t.Name;
    
-- Esercizio 6 Trovate il costo medio per ogni tipologia di media

select 	sub.name as TipologiaDiMedia,
		avg(sub.CostoPer_TipologiaDiMedia) as MediaDelCosto
from
(select 			m.Name,
					sum(i.UnitPrice) as CostoPer_TipologiaDiMedia 
from mediatype m
	inner join track t
on m.MediaTypeId = t.MediaTypeId
	inner join invoiceline i
on t.TrackId = i.TrackId
group by m.name) as sub
group by sub.name;
 
-- Esercizio 7 Individuate il genere con più tracce.

-- questa prima query serve per capire il genere con più tracce
select max(Numero_Tracce)
from 
(select 	g.name,
			count(t.TrackId) as Numero_Tracce
from genre g
inner join track t	
on g.GenreId = t.GenreId
group by g.name) as sub ;

-- questa seconda query restituisce il singolo genere con più tracce

select 	gg.name,
		count(tt.TrackId) as NumeroDiTracce
from genre gg
inner join track tt
on gg.GenreId = tt.GenreId
group by gg.name 
having count(tt.TrackId) >= (select max(Numero_Tracce)
							 from 
							(select 	g.name,
							 count(t.TrackId) as Numero_Tracce
							 from genre g
							 inner join track t	
						     on g.GenreId = t.GenreId
							 group by g.name) as sub);

-- Esercizio 8 Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.

select are.Name as Nome_Artista,
       count(ale.AlbumId) as Numero_Album
from album ale
inner join artist are
on ale.ArtistId = are.ArtistId
group by are.name
having Numero_Album > ( select 	
	   count(al.AlbumId) as NumeroAlbum
from album al
inner join artist ar
on al.ArtistId = ar.ArtistId
where ar.name = 'The Rolling Stones'
group by ar.name);

-- Esercizio 9 Trovate l’artista con l’album più costoso.

select al.Title as Nome_Album, ar.name as Nome_Artista,
        sum(iv.Quantity*iv.UnitPrice) as Totale_Vendita_album
from artist ar
inner join album al
on ar.ArtistId = al.ArtistId
inner join track t
on al.AlbumId = t.AlbumId
inner join invoiceline iv
on t.TrackId = iv.TrackId
inner join invoice i
on iv.InvoiceId = i.InvoiceId
group by al.Title, ar.Name
order by Totale_Vendita_album desc







