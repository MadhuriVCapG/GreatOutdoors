use [Great Outdoors]

/* Stored procedures to Add, Update, Retrieve and Delete Sales Person details from the 
SalesPeople table.

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */



/* Procedure to add Sales person's details into database

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */ 
create procedure 
AddSalesPerson(@salespersonid uniqueidentifier,@salespersonname varchar(30),@mobile char(10),
@email varchar(100),@password varchar(12),@salary money,@bonus money,@target money,@joiningdate datetime,
@addressl1 varchar(500),@addressl2 varchar(500),@city varchar(100),@state varchar(100),@pincode varchar(6),
@birthdate datetime)
as
begin

	declare @lastmodified datetime

	-- Stores the current datetime as last modified
	set @lastmodified = GETDATE()

	-- Inserts the values into the SalesPeople table
	insert into GOUsers.SalesPersons (SalespersonID,[Name],Mobile,Email,[Password],Salary,
	Bonus,[Target],JoiningDate,AddressLine1,AddressLine2,City,[State],Pincode,Birthdate,LastAccountModifiedDateTime)
	 values(@salespersonid,@salespersonname,@mobile,
	@email,@password,@salary,@bonus,@joiningdate,@addressl1,@addressl2,@city,@state,@pincode,
	@birthdate,@lastmodified)

end


/* Procedure to get all the sales people with details

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure GetAllSalesPersons as
begin

	-- Returns the SalesPeople table
	select SalespersonID,[Name],Mobile,Email,[Password],Salary,
	Bonus,[Target],JoiningDate,AddressLine1,AddressLine2,City,[State],Pincode,Birthdate,
	LastAccountModifiedDateTime from GOUsers.SalesPersons 
end

/* Procedure to get sales person by salesperson ID

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure GetSalesPersonBySalesPersonID(@salespersonid uniqueidentifier) as
begin
 -- Returns the Sales Person according to his/her ID
 select SalespersonID,[Name],Mobile,Email,[Password],Salary,
	Bonus,[Target],JoiningDate,AddressLine1,AddressLine2,City,[State],Pincode,Birthdate,LastAccountModifiedDateTime
	 from GreatOutdoors.SalesPersons  where 
	 exists (select SalesPersonID from GOUsers.SalesPersons where SalespersonID = @salespersonid)
end



/* Procedure to get Sales person/people by Name

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure GetSalesPeopleByName(@salespersonname varchar(30)) as
begin
		-- Returns Sales people with given name
		select SalespersonID,[Name],Mobile,Email,[Password],Salary,Bonus,[Target],JoiningDate,
		AddressLine1,AddressLine2,City,[State],Pincode,Birthdate,LastAccountModifiedDateTime
		from GOUsers.SalesPeople where
		exists (select [Name] from GOUsers.SalesPeople where [Name] = @salespersonname)

end
 
/* Procedure to get Sales person by Email

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure GetSalesPersonByEmail(@email varchar(100)) as
begin
	-- Returns Sales person with given email
	 select SalespersonID,[Name],Mobile,Email,[Password],Salary,Bonus,[Target],JoiningDate,
	AddressLine1,AddressLine2,City,[State],Pincode,Birthdate,LastAccountModifiedDateTime
	 from GOUsers.SalesPeople where 
	 exists (select Email from GOUsers.SalesPeople where Email = @email)
end


/* Procedure to get Sales person by Email and Password

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure GetSalesPersonByEmailAndPassword(@email varchar(100),@password varchar(12)) as
begin
		-- Returns Sales person with given email and password
	select SalespersonID,[Name],Mobile,Email,[Password],Salary,Bonus,[Target],JoiningDate,
	AddressLine1,AddressLine2,City,[State],Pincode,Birthdate,LastAccountModifiedDateTime 
	from GOUsers.SalesPeople where exists
	(select Email,[Password] from GOUsers.SalesPeople where Email = @email 
	and [Password] = @password)
end


/* Procedure to update Sales person details

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
 
create procedure UpdateSalesPerson(@salespersonid uniqueidentifier,@name varchar(30),@mobile char(10),@email varchar(100)) as
begin
		update GreatOutdoors.SalesPeople 
		set [Name] = @name, Email = @email, Mobile = @mobile,LastAccountModifiedDateTime = getdate()
		where exists (select SalespersonID from GOUsers.SalesPeople where SalespersonID = @salespersonid)
	
end

/* Procedure to update Sales person's password

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure UpdateSalesPersonPassword(@salespersonid uniqueidentifier,@password varchar(12)) as
begin
	 -- Update password of salesperson and lastmodified date time to current date time
		update GreatOutdoors.SalesPeople 
		set [Password] = @password, LastAccountModifiedDateTime = getdate()
		where exists (select SalespersonID from GOUsers.SalesPeople where SalespersonID = @salespersonid)

end


/* Procedure to delete Sales person from records

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure DeleteSalesPerson(@salespersonid uniqueidentifier) as
begin
    -- Delete sale person's records from the SalesPeople table based on SalespersonID
	delete from GOUsers.SalesPeople where exists 
	(select SalespersonID from GOUsers.SalesPeople where SalespersonID = @salespersonid)

end


