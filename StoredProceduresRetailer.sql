/*
  stored procedures for insert, update, delete and retrieve 

     Project Name   : GreatOutdoors
	 Use Case       : Retailer
	 Developer Name : Sarthak lav 
	 Creation Date  : 01/10/2019
	 Modified Date  : 01/10/2019
*/


--creation of table for Use case: retailer
USE [Great Outdoors]
create table GOUsers.Retailers( 
	  RetailerID  uniqueIdentifier constraint PK_GOUsers_Retailers_RetailerID primary key,
	  RetailerName varchar(50) constraint UQ_RetailerName unique not null,
	  RetailerMobile char(10) constraint UQ_RetailerMobile unique not null,    
	  Email varchar(50) constraint UQ_RetailerEmail unique not null,
	  RetailerPassword varchar(16) constraint UQ_RetailerPassword unique not null,
	  RetailerDiscountPercentage decimal(2,2) constraint UQ_RetailerDiscountPercentage 
		unique check(RetailerDiscountPercentage >=0),
	  CreationDateTime datetime not null,
	  ModifiedDateTime datetime
)



create procedure GOUsers.AddRetailer(@retailerID uniqueIdentifier, @retailerName varchar(50) ,@retailerMobile char(10), @email varchar(50),
                             @retailerPassword varchar(16), @creationDateTime datetime, @modifiedDateTime datetime)
as 
begin             -- stored procedure to insert retailer details
	if @retailerID is null
			throw 50002,'Invalid Retailer ID',1

	if  @retailerName is null
			throw 50002,'Invalid Retailer Name',2

	if @retailerMobile is null
		   throw 50002,'Invalid Retailer mobile',3

	if @email is null
		   throw 50002,'Invalid Email',4

	if @retailerPassword is null
		   throw 50002,'Invalid Password ',5

insert into GOUsers.Retailers(RetailerID, RetailerName, RetailerMobile, Email, RetailerPassword, CreationDateTime, ModifiedDateTime) values(@retailerID, @retailerName, @retailerMobile,
                    @email, @retailerPassword, @creationDateTime, @modifiedDateTime);
end


/*   
  Stored procedures to retrieve all retailers details 
     Project Name       : GreatOutdoors
	 Use Case           : Retailer
	 Developer Name     : Sarthak lav 
	 Creation Date      : 01/10/2019
	 Modified Date      : 01/10/2019
	 
*/

create procedure GOUsers.GetAllRetailers
as        
begin            

select RetailerID, RetailerName, RetailerMobile, Email, RetailerPassword, CreationDateTime, ModifiedDateTime from GOUsers.Retailers;

end
GO

/*   
  Stored procedures to retrieve retailer details by retailer Id 
     Project Name       : GreatOutdoors
	 Use Case           : Retailer
	 Developer Name     : Sarthak lav 
	 Creation Date      : 01/10/2019
	 Modified Date      : 01/10/2019
	 
*/

create procedure GOUsers.GetRetailerByRetailerID(@retailerID uniqueidentifier)
as
begin             
if exists (select RetailerID from GOUsers.Retailers where RetailerID = @retailerID)
begin
select RetailerID, RetailerName, RetailerMobile, Email, RetailerPassword, CreationDateTime, ModifiedDateTime from GOUsers.Retailers where RetailerID = @retailerID;
end
else
throw 50009,'Retailer Not Found.',1
end
GO


/*   
  Stored procedure to retrieve retailer details by retailer name
     Project Name       : GreatOutdoors
	 Use Case           : Retailer
	 Developer Name     : Sarthak lav 
	 Creation Date      : 01/10/2019
	 Modified Date      : 01/10/2019
	 
*/
create procedure GOUsers.GetRetailerByName(@retailerName varchar(50))
as
begin       
if exists (select RetailerName from GOUsers.Retailers where RetailerName = @retailerName)
select RetailerID, RetailerName, RetailerMobile, Email, RetailerPassword, CreationDateTime, ModifiedDateTime from GOUsers.Retailers where RetailerName = @retailerName; 
else 
throw   50009,'Retailer Not Found.',1
end
GO

/*   
  Stored procedure to retrieve retailer details by retailer email
     Project Name       : GreatOutdoors
	 Use Case           : Retailer
	 Developer Name     : Sarthak lav 
	 Creation Date      : 01/10/2019
	 Modified Date      : 01/10/2019
	 
*/
create procedure GOUsers.GetRetailerByEmail (@email varchar(50))
as
begin 
if exists (select Email from GOUsers.Retailers where Email = @email)
select RetailerID, RetailerName, RetailerMobile, Email, RetailerPassword, CreationDateTime, ModifiedDateTime from GOUsers.Retailers where email = @email; 
else
throw   50009,'Retailer Not Found.',1
end
GO



/*   
  Stored procedure to retrieve retailer details by retailer email and password
     Project Name       : GreatOutdoors
	 Use Case           : Retailer
	 Developer Name     : Sarthak lav 
	 Creation Date      : 01/10/2019
	 Modified Date      : 01/10/2019
	 
*/
create procedure GOUsers.GetRetailerByEmailAndPassword (@email varchar(50), @retailerPassword varchar(16))
as
begin    
if exists (select Email,RetailerPassword from GOUsers.Retailers where Email = @email and RetailerPassword=@retailerPassword)
select RetailerID, RetailerName, RetailerMobile, Email, RetailerPassword, CreationDateTime, ModifiedDateTime from GOUsers.Retailers where email = @email and RetailerPassword = @retailerPassword;
else
throw   50009,'Retailer Not Found.',1
end
GO


/*   
  Stored procedure to update retailer details 
     Project Name       : GreatOutdoors
	 Use Case           : Retailer
	 Developer Name     : Sarthak lav 
	 Creation Date      : 01/10/2019
	 Modified Date      : 01/10/2019
	 
*/
create procedure GOUsers.UpdateRetailer(@retailerID uniqueidentifier, @retailerName varchar(50),@retailerMobile char(10), @email varchar(50),
                                        @modifiedDateTime datetime)
as    
begin
begin try
           
		  if exists (select * from GOUsers.Retailers where RetailerID = @retailerID)
	        update GOUsers.Retailers 
				set
				RetailerName      = @retailerName,
			    RetailerMobile    = @retailerMobile,
				Email             = @email,			    
				ModifiedDatetime  = @modifiedDateTime
			where RetailerID = @retailerID 
											

end try
begin catch
 PRINT @@ERROR;
 throw 50015,'Retailer not updated.',3
 return 0
end catch
end
GO


/*   
  Stored procedure to delete retailer details 
     Project Name       : GreatOutdoors
	 Use Case           : Retailer
	 Developer Name     : Sarthak lav 
	 Creation Date      : 01/10/2019
	 Modified Date      : 01/10/2019
	 
*/
create procedure GOUsers.DeleteRetailer(@retailerID uniqueidentifier)
as
begin
	begin try         
		if exists (select * from GOUsers.Retailers where RetailerID = @retailerID)
			delete from GOUsers.Retailers where RetailerID = @retailerID;
	end try
	begin catch
		 PRINT @@ERROR;
		 throw 50016,'Values not deleted.',2
		 return 0
	end catch
end
GO



/*   
  Stored procedure to update retailer password
     Project Name       : GreatOutdoors
	 Use Case           : Retailer
	 Developer Name     : Sarthak lav 
	 Creation Date      : 01/10/2019
	 Modified Date      : 01/10/2019
	 
*/
create procedure GOUsers.UpdatePassword(@retailerID uniqueidentifier, @retailerPassword varchar(16))
as
begin
begin try     
		if exists (select * from GOUsers.Retailers where RetailerID = @retailerID)
		   update GOUsers.Retailers
		   set
		   RetailerPassword = @retailerPassword
		   where RetailerID = @retailerID

end try
begin catch
 PRINT @@ERROR;
 throw 50017,'Password not updated.',3
 return 0
end catch
end
GO