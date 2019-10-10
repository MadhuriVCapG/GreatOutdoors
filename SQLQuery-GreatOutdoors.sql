use [Great Outdoors]

/* Table containing details of each Sales person

Project name : Great Outdoors
Developer name: Madhuri Vemulapaty
Use case : Sales person
Creation date : 30/09/2019
Last modified : 01/10/2019

 */ 
create table GOUsers.SalesPersons
(
	SalespersonID uniqueidentifier not null  
		constraint pk_GOUsers_SalesPersons_SalespersonID primary key(SalespersonID) ,
	[Name] varchar(30) not null
		constraint uq_GOUsers_SalesPersons_Name unique ([Name]), 
	Mobile char(10) not null 
		constraint uq_GOUsers_SalesPersons_Mobile unique (Mobile),
	Email varchar(100) 
		constraint uq_GOUsers_SalesPersons_Email unique (Email),
	[Password] varchar(12) not null,
	Salary money,
	Bonus money,
	[Target] money,
	JoiningDate datetime not null 
		constraint ck_GreatOutdoors_SalesPersons_CheckIfJoiningDateIsAfter2012 check (JoiningDate >= 2012/01/01), 
	AddressLine1 varchar(500),
	AddressLine2 varchar(500),
	City varchar(100),
	[State] varchar(100),
	Pincode varchar(6),
	Birthdate datetime not null
		constraint ck_GOUsers_SalesPersons_CheckIfBirthDateIsAfter1950
		 check (Birthdate between '1950-01-01' and '2012-01-01'),
	LastAccountModifiedDateTime datetime
)


/* Table containing details of each Product

Developer name: Madhuri Vemulapaty
Use case : Product
Creation date : 30/09/2019
Last modified : 01/10/2019

 */
Create table GOOrders.Products
(
	ProductID uniqueidentifier 
		constraint pk_GOUsers_Products_ProductID primary key(ProductID),
	[Name] varchar(50) not null,
	Category varchar(30) not null,
	[Image] image,
	Stock int,
	Size varchar(4),
	Colour varchar (20) not null,
	TechnicalSpecifications varchar(5000) not null,
	CostPrice money not null
		constraint ck_GOUsers_Products_CostPriceCanNotBeNegative check (CostPrice >= 0) , 
	SellingPrice money not null
		constraint ck_GOUsers_Products_SellingPriceCanNotBeNegative check (SellingPrice >= 0),
	DiscountPercentage decimal(2,2)
		constraint ck_GOUsers_Products_DiscountPercentageCanNotBeNegative check (DiscountPercentage >= 0)
	 
)


