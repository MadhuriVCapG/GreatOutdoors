USE [Great Outdoors]
Create Table GOOrders.OrderDetails
(
OrderDetailID uniqueidentifier
Constraint PK_GOOrders_OrderDetails_OrderDetailID PRIMARY KEY,
OrderID uniqueidentifier NOT NULL
Constraint FK_GOOrders_OrderDetails_GOOrders_Orders_OrderID FOREIGN KEY
REFERENCES GOOrders.Orders(OrderID),
ProductID uniqueidentifier NOT NULL
Constraint FK_GOOrders_OrderDetails_GOOrders_Products_ProductID FOREIGN KEY
REFERENCES GOOrders.Products(ProductID),
Quantity int NOT NULL CHECK (Quantity > 0),
DiscountedUnitPrice decimal(15,2) NOT NULL CHECK (DiscountedUnitPrice>0),
TotalPrice decimal(15,2) NOT NULL CHECK (TotalPrice>0),
GiftPacking bit Default 0,
AddressID uniqueidentifier NOT NULL
Constraint FK_GOOrders_OrderDetails_GOOrders_Addresses_AddressID FOREIGN KEY
REFERENCES GOOrders.Addresses(AddressID),
CurrentStatus varchar(15) NOT NULL,
CreatedDateTime datetime,
ModifiedDateTime datetime
)
GO




Create Procedure GOOrders.AddOrderDetails(@orderDetailID uniqueidentifier, @orderID uniqueidentifier,@productID uniqueidentifier, @quantity int, @discountedUnitPrice int, @totalPrice int, @giftPacking bit, @addressID uniqueidentifier)
as
begin
if @orderDetailID is null
throw 50001,'Invalid Order Detail ID',1
if @orderID is null
throw 50001,'Invalid Order ID',2
if @productID is null
throw 50001, 'Invalid Product ID',3
if @quantity = 0
throw 50001,'Quantity Cannot Be 0',4
if @discountedUnitPrice = 0
throw 50001, 'Invalid Discounted Price',5
if @totalPrice = 0
throw 50001,'Invalid Total Price',6
if @giftPacking <0 OR @giftPacking >1
throw 50001,'Invalid Entry in Gift Packing',7
if @addressID is null
throw 50001, 'Invalid Address ID',0
INSERT INTO GreatOutdoors.OrderDetails(OrderDetailID, OrderID, ProductID, Quantity, DiscountedUnitPrice, TotalPrice, GiftPacking, AddressID, CreatedDateTime, ModifiedDateTime)
VALUES(@orderDetailID, @orderID, @productID, @quantity, @discountedUnitPrice, @totalPrice, @giftPacking, @addressID, sysdatetime(), sysdatetime())
end
GO


Create Procedure GOOrders.GetOrderDetailsByOrderID(@orderID uniqueidentifier)
as
begin
begin try
if exists (Select OrderID from GOOrders.OrderDetails where OrderID = @orderID)
 begin
 Select OrderDetailID, OrderID, ProductID, Quantity, DiscountedUnitPrice, TotalPrice, GiftPacking, AddressID
 from GOOrders.OrderDetails where OrderID = @orderID
 end
end try
begin catch
 throw 50000,'Order Does Not Exist.',1
 return 0
end catch
end
GO

Create Procedure GOOrders.GetOrderDetailsByProductID(@productID uniqueidentifier)
as
begin
begin try
if exists (Select ProductID from GOOrders.OrderDetails where ProductID = @productID)
 begin
 Select OrderDetailID, OrderID, ProductID, Quantity, DiscountedUnitPrice, TotalPrice, GiftPacking, AddressID
 from GOOrders.OrderDetails where ProductID = @productID
 end
end try
begin catch
 throw 50000,'Product Does Not Exist.',2
 return 0
end catch
end
GO



Create Procedure GOOrders.DeleteOrderDetails(@orderID uniqueidentifier, @productID uniqueidentifier)
as
begin
begin try
if exists (Select OrderID, ProductID from GOOrders.OrderDetails where OrderID = @orderID and ProductID = @productID)
 begin
 DELETE FROM GOOrders.OrderDetails WHERE OrderID = @orderID AND ProductID = @productID
 end
end try
begin catch
 throw 50000,'No such record exists.',3
 return 0
end catch
end
GO




Create Procedure GOOrders.UpdateOrderDetailStatus(@orderID uniqueidentifier, @productID uniqueidentifier, @currentStatus varchar(15))
as
begin
begin try
if exists (Select OrderID, ProductID from GOOrders.OrderDetails where OrderID = @orderID and ProductID = @productID)
 begin
 Update GOOrders.OrderDetails
 SET CurrentStatus = @currentStatus
 where OrderID = @orderID and ProductID = @productID
 end
end try
begin catch
throw 50000,'No such record exists.',3
end catch
end
GO










Create Table GOOrders.Orders
(
OrderID uniqueidentifier NOT NULL
Constraint PK_GOOrders_Orders_OrderID PRIMARY KEY,
RetailerID uniqueidentifier
Constraint FK_GOOrders_Orders_GOUsers_Retailers_RetailerID FOREIGN KEY
REFERENCES GOUsers.Retailers(RetailerID),
SalespersonID uniqueidentifier
Constraint FK_GOOrders_Orders_GOUsers_Salespersons_SalespersonID FOREIGN KEY
REFERENCES GOUsers.Salespersons(SalespersonID),
TotalQuantity int NOT NULL CHECK (TotalQuantity>0),
TotalAmount decimal(15,2) NOT NULL CHECK (TotalAmount > 0),
ChannelOfSale char(7) NOT NULL CHECK (ChannelOfSale = 'Online' OR ChannelOfSale='Offline'),
OrderDateTime datetime ,
ModifiedDateTime datetime
 )
GO











Create Procedure GOOrders.AddOrder(@orderID uniqueidentifier, @retailerID uniqueidentifier,@salespersonID uniqueidentifier, @totalQuantity int, @totalAmount decimal(15,2), @channelOfSale char(7))
as
begin
if @orderID is null
throw 50002,'Invalid Order ID',1
if @totalQuantity = 0
throw 50002,'Total Quantity Entered is 0',4
if @totalAmount = 0
throw 50002, 'Invalid Total Amount',5
if @channelOfSale != 'Offline' AND @channelOfSale != 'Online'
throw 50002,'Invalid Channel Of Sale',6
if @retailerID is null AND @salespersonID is null
throw 50002, 'Both retailerID and salesmanID are null. ',8
if @salespersonID is NULL OR @retailerID is null
 begin
 INSERT INTO GreatOutdoors.Orders(OrderID, RetailerID, SalespersonID, TotalQuantity, TotalAmount, ChannelOfSale, OrderDateTime, ModifiedDateTime)
 VALUES(@orderID, @retailerID, @salespersonID, @totalQuantity, @totalAmount, @channelOfSale, sysdatetime(),sysdatetime())
 end
end
GO



Create Procedure GOOrders.GetOrdersByOrderID(@orderID uniqueidentifier)
as
begin
begin try
Select OrderID, RetailerID, SalespersonID, TotalQuantity, TotalAmount,
ChannelOfSale, OrderDateTime, ModifiedDateTime from GOOrders.Orders where OrderID = @orderID
end try
begin catch
 PRINT @@ERROR;
 throw 50005,'Invalid values fetched.',2
 return 0
end catch
end
GO


Create Procedure GOOrders.GetOrdersbyRetailerID(@retailerID uniqueidentifier)
as
begin
begin try
if exists (Select RetailerID from GOOrders.Orders where RetailerID = @retailerID)
begin
Select OrderID, RetailerID, SalespersonID, TotalQuantity, TotalAmount, ChannelOfSale,
OrderDateTime, ModifiedDateTime from GOOrders.Orders where RetailerID = @retailerID
end
end try
begin catch
 PRINT @@ERROR;
 throw 50005,'No such retailer exists.',2
 return 0
end catch
end
GO

Create Procedure GOOrders.GetOrdersBySalespersonID(@salespersonID uniqueidentifier)
as
begin
begin try
if exists (Select SalespersonID from GOOrders.Orders where SalespersonID = @salespersonID )
begin
Select OrderID, RetailerID, SalespersonID, TotalQuantity, TotalAmount, ChannelOfSale, OrderDateTime,
ModifiedDateTime from GOOrders.Orders where SalespersonID = @salespersonID
end
end try
begin catch
 PRINT @@ERROR;
 throw 50005,'No such record exists.',2
 return 0
end catch
end
GO




Create Procedure GOOrders.GetOrderOnlineSold
as
begin
begin try
Select OrderID, RetailerID, SalespersonID, TotalQuantity, TotalAmount, ChannelOfSale, OrderDateTime,
ModifiedDateTime from GOOrders.Orders where ChannelOfSale= 'Online'
end try
begin catch
 PRINT @@ERROR;
 throw 50005,'Invalid values fetched.',2
 return 0
end catch
end
GO