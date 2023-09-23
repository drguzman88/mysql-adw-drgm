use adw;

-- Empleados
select 
    count(SalesOrderID) as conteo,
    -- OrderDate,
    -- sales.CustomerID,
    -- SalesPersonID,
    -- sales.TerritoryID,
    -- concat(person.FirstName,' ',person.LastName) as CustomerName,
    concat(emp.FirstName,' ',emp.LastName) as SalesName,
    -- territory.Name as Territory,
    -- employee.Gender as Gender
from Sales_SalesOrderHeader as sales
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
limit 5
;

