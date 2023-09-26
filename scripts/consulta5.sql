use adw;

with datos as (

select 
    SalesOrderID,
    OrderDate,
    sales.CustomerID,
    SalesPersonID,
    sales.TerritoryID,
    concat(person.FirstName,' ',person.LastName) as CustomerName,
    concat(emp.FirstName,' ',emp.LastName) as SalesName,
    year(OrderDate) as Anno,
    territory.Name as Territory,
    employee.Gender as Gender
from Sales_SalesOrderHeader as sales
    join Sales_Customer as client 
        on sales.CustomerID = client.CustomerID
    left outer join Person_Person as person 
        on client.PersonID = person.BusinessEntityID
    join Sales_SalesPerson as sp
        on sales.SalesPersonID = sp.BusinessEntityID
    join Person_Person as emp
        on sp.BusinessEntityID = emp.BusinessEntityID
    join Sales_SalesTerritory as territory
        on sales.TerritoryID=territory.TerritoryID
    join HumanResources_Employee as employee 
        on emp.BusinessEntityID=employee.BusinessEntityID
),

datos2 as (
select Anno as Year,count(*) as Ventas
from datos
group by Year
),

datos3 as(
select
    sum(case when year = 2011 then Ventas else 0 end) ventas11,
    sum(case when year = 2012 then Ventas else 0 end) ventas12,
    sum(case when year = 2013 then Ventas else 0 end) ventas13,
    sum(case when year = 2014 then Ventas else 0 end) ventas14
from datos2
)
select ((ventas12 - ventas11)/ventas11)*100 as varventas12,
       ((ventas13 - ventas12)/ventas12)*100 as varventas13,
       ((ventas14 - ventas13)/ventas13)*100 as varventas14
from datos3







