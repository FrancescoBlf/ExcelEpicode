-- 1.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).
select d.ProductKey,
	   d.EnglishProductName,
       d.Color,
       d.EnglishDescription,
       d.Class,
	   dps.EnglishProductSubcategoryName,
       dps.ProductSubcategoryKey
       from dimproduct as d
       inner join dimproductsubcategory as dps
       on d.ProductSubcategoryKey = dps.ProductSubcategoryKey;
       
       -- 2.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).

	select d.ProductKey,
	   d.EnglishProductName,
       d.Color,
       d.EnglishDescription,
       d.Class,
	   dps.EnglishProductSubcategoryName,
       dps.ProductSubcategoryKey,
       dpc.EnglishProductCategoryName
       from dimproduct as d
       inner join dimproductsubcategory as dps
       on d.ProductSubcategoryKey = dps.ProductSubcategoryKey
       inner join dimproductcategory as dpc
       on dps.ProductSubcategoryKey = dpc.ProductCategoryKey;
       
       -- 3.Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales).
       
       select f.ProductKey, 
              d.EnglishProductName
       from dimproduct as d
       inner join factresellersales as f
       on d.ProductKey = f.ProductKey;
       -- 3.b Esponi l’elenco dei soli prodotti non venduti (DimProduct, FactResellerSales).
       
       select f.ProductKey,
              d.EnglishProductName
       from dimproduct as d
       left join factresellersales as f
       on d.ProductKey = f.ProductKey
       where f.SalesOrderNumber is null;
     
       
       -- 4.Esponi l’elenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).
       
       select d.ProductKey,
              d.EnglishProductName,
              d.Color
       from dimproduct as d
       left join factresellersales as f
       on d.ProductKey = f.ProductKey
       where d.FinishedGoodsFlag = 1 
       and  f.SalesOrderNumber is null;
       
       -- ** subquery **
       
       select d.ProductKey,
              d.EnglishProductName,
              d.Color
       from dimproduct as d 
       where d.FinishedGoodsFlag = 1
       and ProductKey not in ( select ProductKey
							   from factresellersales as f
                               where f.SalesOrderNumber is not null);
       
        
       
	
       
-- 5.Esponi l’elenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)

 select f.ProductKey,
       f.OrderDate, 
       f.SalesAmount,
       d.EnglishProductName
from factresellersales as f
inner join dimproduct as d
on f.ProductKey = d.ProductKey;



-- 6.Esponi l’elenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.

 select f.ProductKey,
       f.OrderDate, 
       f.SalesAmount,
       d.EnglishProductName,
       dpc.EnglishProductCategoryName
from factresellersales as f
inner join dimproduct as d
on f.ProductKey = d.ProductKey
inner join dimproductsubcategory as dpsc
on d.ProductSubcategoryKey = dpsc.ProductSubcategoryAlternateKey
inner join dimproductcategory as dpc 
on dpsc.ProductCategoryKey = dpc.ProductCategoryKey;

-- 7.Esplora la tabella DimReseller.

select * from dimreseller;

-- 8.Esponi in output l’elenco dei reseller indicando, per ciascun reseller, anche la sua area geografica.

select d.ResellerName,
	   d.Phone,
       d.BusinessType,
       g.GeographyKey,
       g.EnglishCountryRegionName,
       g.City,
       g.PostalCode
from dimreseller as d
inner join dimgeography as g
on d.GeographyKey = g.GeographyKey;

-- 9-Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
-- Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e l’area geografica.

select f.ProductKey,
       f.SalesOrderNumber,
       f.SalesOrderLineNumber,
       f.OrderDate,
       f.OrderQuantity,
       f.TotalProductCost,
       d.EnglishProductName,
       dpc.EnglishProductCategoryName,
       dg.GeographyKey,
       dg.EnglishCountryRegionName,
       dg.City,
       dr.ResellerName
from dimgeography dg
inner join dimreseller as dr
on dg.GeographyKey = dr.GeographyKey
inner join factresellersales as f
on dr.ResellerKey = f.ResellerKey
inner join dimproduct as d
on f.ProductKey = d.ProductKey
inner join dimproductsubcategory as dps
on d.ProductSubcategoryKey = dps.ProductCategoryKey
inner join dimproductcategory as dpc
on dps.ProductCategoryKey = dpc.ProductCategoryKey



