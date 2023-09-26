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
)
select 
    case when Territory in ('Southwest','Northwest','Southeast','Central','Northeast') then 'USA' else Territory end as Territory2, 
    count(*) as Ventas
from datos
group by Territory2
order by Ventas desc

limit 10
;
