USE Test_BI12
--SELECT * FROM "Order_temp"

--Tạo bảng dữ liệu kết nối với PowerBI
SELECT *
into Customer
FROM Test_BI12.dbo.Customer_temp

SELECT * FROM Customer
--Tạo bảng lịch sử cập nhật dữ liệu
SELECT top 1*
into Customer_hist
FROM Test_BI12.dbo.Customer
TRUNCATE TABLE Customer_hist --Xóa dữ liệu trong bảng 

SELECT * FROM Customer_hist

--------------------------------------------------------------------------------------------------------------
USE Test_BI12
-- Load lại dữ liệu từ bảng temps
TRUNCATE TABLE Customer_temp

 
-- import the file
BULK INSERT Customer_temp
FROM 'D:\Data Analyst\Learn\MindX\BI12\Final_test\4.Report automation\Customer.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)



--Xử lí dữ liệu từ bảng nguồn
SELECT * FROM Customer_temp
DELETE FROM Customer_temp 
WHERE COALESCE ("Customer_ID", "Customer_Name", "Segment", "City", "State" ) IS NULL;


--Xóa dữ liệu Customer đi đưa dữ liệu mới từ Customer_temp vào
TRUNCATE TABLE Customer

INSERT INTO Customer
SELECT * FROM Customer_temp

--thêm những dòng dữ liệu mới ở bảng Customer vào bảng Customer_hist
insert into Customer_hist (Customer_ID, Customer_Name, Segment, City, State)
select 
	Customer_hist.Customer_ID
	, Customer_hist.Customer_Name
	, Customer_hist.Segment
	, Customer_hist.City
	, Customer_hist.State
FROM Test_BI12.dbo.Customer
left outer join Customer_hist 
on Customer.Customer_ID = Customer_hist.Customer_ID and Customer.Customer_Name = Customer_hist.Customer_Name
where Customer.Customer_ID is null --điều kiện này để lọc ra những dòng dữ liệu mà chỉ có ở bảng Customer (nghĩa là dữ liệu mới) và insert vào bảng Customer_hist
select * from Customer_hist
select count(1) from Customer










