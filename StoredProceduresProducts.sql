use [Great Outdoors]

/* Stored procedures to Add, Update, Retrieve and Delete Products from the Products table.

Developer name: Madhuri Vemulapaty
Use case : Product
Creation date : 30/09/2019
Last modified : 01/10/2019

 */


/* Procedure to add product into database

Developer name: Madhuri Vemulapaty
Use case : Product
Creation date : 30/09/2019
Last modified : 01/10/2019

 */

create procedure 
AddProduct(@prodid uniqueidentifier,@prodname varchar(50),@category varchar(30),@stock int,@size varchar(4),
@colour varchar(20),@techspecs varchar(1000),@cprice money,@sprice money,@discount decimal,@img image)
as
begin
begin try
	-- Checks if Product cost price is 0 or not, throws error if blank
	if @cprice = 0
			throw 50001,'Invalid cost price',1

	-- Checks if Product selling price is 0 or not, throws error if blank
	else if @sprice = 0
			throw 50001,'Invalid selling price',1

	-- Inserts product details into Products table
	insert into GOOrders.Products(ProductID,[Name],Category,[Image],Stock,Size,Colour,TechnicalSpecifications,
	CostPrice,SellingPrice,Discount) 
	values(@prodid,@prodname,@category,@img,@stock,@size,@colour,@techspecs,@cprice,
	@sprice,@discount)

end try

begin catch 
	throw		
end catch
end

 
/* Procedure to get all the products with details

Developer name: Madhuri Vemulapaty
Use case : Product
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure GetAllProducts as
begin
	-- Returns products table from Products
	select ProductID,[Name],Category,[Image],Stock,Size,Colour,TechnicalSpecifications,
	CostPrice,SellingPrice,Discount from GOOrders.Products
end


/* Procedure to get product by ProductID

Developer name: Madhuri Vemulapaty
Use case : Product
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure GetProductByProductID(@prodid uniqueidentifier) as
begin
 select ProductID,[Name],Category,[Image],Stock,Size,Colour,TechnicalSpecifications,
	CostPrice,SellingPrice,Discount from GOOrders.Products where ProductID = @prodid
end


/* Procedure to get products by Name

Developer name: Madhuri Vemulapaty
Use case : Product
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure GetProductsByName(@prodname varchar(50)) as
begin
    	--Returns products from the Products table with the given product name
		select ProductID,[Name],Category,[Image],Stock,Size,Colour,TechnicalSpecifications,
	CostPrice,SellingPrice,Discount from GOOrders.Products where [Name] = @prodname 
end

/* Procedure to get products by Category 

Developer name: Madhuri Vemulapaty
Use case : Product
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure GetProductsByCategory(@category varchar(30)) as
begin
    	-- Returns products which belong to the given category
		select ProductID,[Name],Category,[Image],Stock,Size,Colour,TechnicalSpecifications,
	CostPrice,SellingPrice,Discount from GOOrders.Products where Category = @category
end


/* Procedure to update product details

Developer name: Madhuri Vemulapaty
Use case : Product
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure UpdateProductDetails(@prodid uniqueidentifier,@prodname varchar(50),
@category varchar(30),@size varchar(4),@colour varchar(20),@techspecs varchar(1000)) as
begin
	-- updates products with the given details based on the productid
	update GOOrders.Products 
	set [Name] = @prodname, Category = @category, Size =@size, Colour = @colour, 
	TechnicalSpecifications = @techspecs where 
	exists (select ProductID from GOOrders.Products where ProductID=@prodid)
end


/*Procedure to delete product

Developer name: Madhuri Vemulapaty
Use case : Product
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure DeleteProduct(@prodid uniqueidentifier) as
begin
	-- Deletes product based on given productid
	delete from GOOrders.Products where
	exists (select ProductID from GOOrders.Products where ProductID=@prodid)
end


/*Procedure to update product stock

Developer name: Madhuri Vemulapaty
Use case : Product
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
create procedure UpdateProductStock(@prodid uniqueidentifier,@stock int) as
begin
	-- updates stock of product based on productid
	update GOOrders.Products set Stock = @stock where
	exists (select ProductID from GOOrders.Products where ProductID=@prodid)

end

