-- 1.Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?

select ProductKey from dimproduct
where ProductKey is null;

select count(*)
from dimproduct
group by
ProductKey
having count(*) > 1;

-- 2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.
 
 select count(*) 
 from factresellersales
 group by 
 SalesOrderNumber, SalesOrderLineNumber
 having count(*) > 1;
 
  select count(*) 
 from factresellersales
 group by 
 SalesOrderNumber
 having count(*) > 1;
 
  select count(*) 
 from factresellersales
 group by 
SalesOrderLineNumber
 having count(*) > 1 ;
 
-- 3.Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.
 
 select count(SalesOrderLineNumber) as conteggio, OrderDate
 from factresellersales
 group by 
 OrderDate
 having OrderDate >= '2020-01-01';
 
--  4.Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) 
--  e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
--  Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!

select                     d.EnglishProductName as Nome_Prodotto            
                          ,sum(f.SalesAmount) as Fatturato_totale
                          , sum(f.OrderQuantity) as Quantità_totale_venduta
                          ,avg(UnitPrice) as Prezzo_medio_vendita
                          ,f.OrderDate
from factresellersales as f
inner join dimproduct as d
on f.ProductKey = d.ProductKey 
where OrderDate >= '2020-01-01'
group by 
d.EnglishProductName
order by 
OrderDate ;

-- 5.Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory). 
-- Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!

select                        dpc.EnglishProductCategoryName as Categoria_Prodotto
                             ,sum(f.SalesAmount) as Fatturato_Totale
                             ,sum(f.OrderQuantity) as Quantità_venduta
from factresellersales as f
inner join dimproduct as d
on f.ProductKey = d.ProductKey
inner join dimproductsubcategory as dpsc
on  d.ProductSubcategoryKey = dpsc.ProductSubcategoryAlternateKey
inner join dimproductcategory as dpc
on dpsc.ProductCategoryKey = dpc.ProductCategoryKey
group by dpc.EnglishProductCategoryName;

-- 6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
-- Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.


select                 dg.City as Area_Città
					  ,sum(f.SalesAmount) as Fatturato_Città 
from factresellersales as f
inner join dimsalesterritory as dm
on f.SalesTerritoryKey = dm.SalesTerritoryKey
inner join dimgeography as dg
on dm.SalesTerritoryKey = dg.SalesTerritoryKey
where OrderDate >= '2020-01-01'
group by 
dg.City
having sum(f.SalesAmount) > 60000
order by sum(f.SalesAmount) desc;



