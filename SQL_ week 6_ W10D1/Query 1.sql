SELECT 
	ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag
FROM
    dimproduct
WHERE
    FinishedGoodsFlag = 1;
    
    
SELECT 
	ProductAlternateKey, ProductAlternateKey, Style, ModelName, StandardCost, ListPrice, ListPrice - StandardCost as Ricavo
FROM
    dimproduct
WHERE
    ProductAlternateKey LIKE 'FR%'
    OR
    ProductAlternateKey LIKE 'BK%'
     

select 
ListPrice, Status
from
dimproduct
where ListPrice between 1000 AND 2000
and 
Status is null;

select 
SalespersonFlag, concat(firstname,' ',lastname) as impiegato
from
dimemployee
where 
SalesPersonFlag = 1;

select
OrderDate, ProductKey, SalesAmount - TotalProductCost as profitto
from
factresellersales
where ProductKey IN ('597', '598','477', '214')
and
OrderDate between 2020-01-01 and 2024-04-10;
