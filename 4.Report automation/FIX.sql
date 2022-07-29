UPDATE Customer SET Customer_ID = 1
where  Customer_ID is null
ALTER TABLE Customer
ALTER COLUMN Customer_ID bit Not Null

UPDATE Customer SET State = 1
where  State is null
ALTER TABLE Customer
ALTER COLUMN State bit Not Null

