/*
Project Name: Great Outdoors
Developer Name: Shreyash Pandey
Use Case: Address
Date of creation (DD/MM/YYYY): 30/09/2019
Last Modified (DD/MM/YYYY): 01/10/2019 
*/






--Creation of GreatOutdoors Database







--Creation of GreatOutdoors Schema
Use [Great Outdoors]






--Creation of Addresses table
Create Table GOOrders.Addresses(
AddressID uniqueidentifier constraint PK_GOUsers_Addresses_AddressID primary key,
RetailerID uniqueidentifier not null constraint FK_GOUsers_Addresses_RetailerID foreign key references GOUsers.Retailers(RetailerID),
Line1 varchar(100) Not Null,
Line2 varchar(100) Null,
City varchar(20) Not Null,
Pincode int Not Null,
States varchar(15) Not Null,
MobileNo char(10) Not Null constraint UQ_MobileNo unique,
CreationDateTime DateTime Not Null,
LastModifiedDateTime DateTime Not Null
)






--Dropping the Addresses table from database
Drop Table GoOrders.Addresses;






--Creation of a stored procedure AddAddress which adds addresses to the Addesses Table.
Create Procedure AddAddress
(
--Parameters for the AddAddress procedure
@AddressID varchar(20),
@RetailerID varchar(20),
@Line1 varchar(100),
@Line2 varchar(100),
@City varchar(20),
@Pincode char(6),
@State varchar(15),
@MobileNo char(10),
@CreationDateTime DateTime,
@LastModifiedDateTime DateTime
)
as
begin 
--Validation of the parameters
if @AddressID is null OR @AddressID = ''
throw 5001,'Invalid Address ID',1
if @RetailerID is null OR @RetailerID = ''
throw 5001,'Invalid Retailer ID',1
if @Line1 is null OR @Line1 = ''
throw 5001, 'Invalid Line1',1
if @Line2 is null OR @Line2 = ''
throw 5001, 'Invalid Line1',1
if @City is null OR @City = ''
throw 5001, 'Invalid City',1
if @Pincode is null OR @Pincode = ''
throw 5001,'Invalid Pincode',1
if @State is null OR @State = ''
throw 5001,'Invalid State',1
if @MobileNo is null OR @MobileNo = ''
throw 5001, 'Invalid Mobile Number',1
if @CreationDateTime is null OR @CreationDateTime = ''
throw 5001, 'Invalid Creation Date and Time',1
if @LastModifiedDateTime is null OR @LastModifiedDateTime = ''
throw 5001, 'Invalid Last Modified Date and Time',1

--Inserting the values to the addresses table. 
insert into GoUsers.Addresses
values 
(@AddressID,@RetailerID,@Line1,@Line2,@City,@Pincode,@State,@MobileNo,
@CreationDateTime,@LastModifiedDateTime)
end






--Creation of a stored procedure GetAllAddress which gets all the addresses' data of the Addesses Table. 
Create Procedure GetAllAddresses
as
begin
--Exception handling
begin try
--Getting all the Address from Addresses table
select * from GOOrders.Addresses
end try
begin catch
PRINT @@ERROR;
throw 5000,'Invalid values fetched',1
return 0
end catch
end






--Creation of a stored procedure AddAddress which adds addresses to the Addesses Table.
Create Procedure GetAddressByRetailerID(@RetailerID varchar(5))
as 
begin
--Exception handling
begin try
--Select all the addresses of the retailer
select * from GOOrders.Addresses a inner join GOOrders.Retailers r on a.RetailerID = r.RetailerID
end try
begin catch
PRINT @@ERROR;
throw 5000,'Invalid values fetched',2
return 0
end catch
end






--Creation of a stored procedure UpdateAddress which updates addresses in the Addesses Table.
Create Procedure UpdateAddress(@AddressID varchar(20),@RetailerID varchar(20),
@Line1 varchar,@Line2 varchar,@City varchar,@Pincode int,@State varchar,@MobileNo varchar,
@CreationDateTime DateTime,@LastModifiedDateTime DateTime)
as
begin
--Validation of the parameters 
if @AddressID is null OR @AddressID = ''
throw 5001,'Invalid Address ID',1
if @RetailerID is null OR @RetailerID = ''
throw 5001,'Invalid Retailer ID',1
if @Line1 is null OR @Line1 = ''
throw 5001, 'Invalid Line1',1
if @Line2 is null OR @Line2 = ''
throw 5001, 'Invalid Line1',1
if @City is null OR @City = ''
throw 5001, 'Invalid City',1
if @Pincode is null OR @Pincode = ''
throw 5001,'Invalid Pincode',1
if @State is null OR @State = ''
throw 5001,'Invalid State',1
if @MobileNo is null OR @MobileNo = ''
throw 5001, 'Invalid Mobile Number',1
if @CreationDateTime is null OR @CreationDateTime = ''
throw 5001, 'Invalid Creation Date and Time',1
if @LastModifiedDateTime is null OR @LastModifiedDateTime = ''
throw 5001, 'Invalid Last Modified Date and Time',1
--Exception handling
begin try
--Update details in the table
update GoOrders.Addresses
set
Line1=@Line1,
Line2=@Line2,
City=@City,
Pincode=@Pincode,
States=@State,
MobileNo=@MobileNo
where AddressID=@AddressID
end try
begin catch
PRINT @@ERROR;
throw 5000,'Values Not Updated',3
return 0
end catch
end






--Creation of a stored procedure DeleteAddress which deletes addresses from the Addesses Table.
Create Procedure DeleteAddress(@AddressID varchar(20))
as 
begin
--Validation of the parameter
if @AddressID is null OR @AddressID = ''
throw 5001,'Invalid Address ID',1
--Exception handling
begin try
--Deleting the Address for Addresses table
delete from GOOrders.Addresses where AddressID=@AddressID 
end try
begin catch
PRINT @@ERROR;
throw 5000,'Values not deleted.',4
return 0
end catch
end
