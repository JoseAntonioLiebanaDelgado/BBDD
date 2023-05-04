CREATE DATABASE supermarket DEFAULT CHARACTER SET 'utf8' DEFAULT COLLATE 'utf8_bin';

USE supermarket;

CREATE TABLE IF NOT EXISTS Suppliers (
    SupplierID INT AUTO_INCREMENT NOT NULL,
    CompanyName VARCHAR(20),
    ContactName VARCHAR(20),
    ContactTitle VARCHAR(20),
    Address VARCHAR(50),
    City VARCHAR(50),
    Region VARCHAR(20),
    PostalCode INT,
    Country VARCHAR(20),
    Phone VARCHAR(20),
    Fax VARCHAR(20),
    HomePage VARCHAR(255),
    PRIMARY KEY(SupplierID)
);

CREATE TABLE IF NOT EXISTS Categories (
    CategoryID INT AUTO_INCREMENT NOT NULL,
    CategoryName VARCHAR(20),
    Description VARCHAR(50),
    Picture VARCHAR(255),
    PRIMARY KEY(CategoryID)
);

CREATE TABLE IF NOT EXISTS Products (
    ProductID INT AUTO_INCREMENT NOT NULL,
    ProductName VARCHAR(20),
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit DECIMAL,
    UnitPrice DECIMAL,
    UnitsinStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BOOLEAN,
    PRIMARY KEY(ProductID),
    FOREIGN KEY(SupplierID) REFERENCES Suppliers(SupplierID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(CategoryID) REFERENCES Categories(CategoryID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT AUTO_INCREMENT NOT NULL,
    CompanyName VARCHAR(20),
    ContactName VARCHAR(20),
    ContactTitle VARCHAR(20),
    Address VARCHAR(50),
    City VARCHAR(50),
    Region VARCHAR(20),
    PostalCode INT,
    Country VARCHAR(20),
    Phone VARCHAR(20),
    Fax VARCHAR(20),
    PRIMARY KEY(CustomerID)
);

CREATE TABLE IF NOT EXISTS Shippers (
    ShipperID INT AUTO_INCREMENT NOT NULL,
    CompanyName VARCHAR(20),
    Phone VARCHAR(20),
    PRIMARY KEY(ShipperID)
);

CREATE TABLE IF NOT EXISTS Employees (
    EmployeesID INT AUTO_INCREMENT NOT NULL,
    LastName VARCHAR(20),
    FirstName VARCHAR(20),
    Title VARCHAR(50),
    TitleOfCourtesy VARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Address VARCHAR(50),
    City VARCHAR(50),
    Region VARCHAR(20),
    PostalCode INT,
    Country VARCHAR(20),
    HomePage VARCHAR(255),
    Extension VARCHAR(20),
    Photo VARCHAR(255),
    Notes VARCHAR(100),
    ReportsTo INT,
    PhotoPath VARCHAR(255),
    PRIMARY KEY(EmployeesID),
    FOREIGN KEY(ReportsTo) REFERENCES Employees(EmployeesID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT AUTO_INCREMENT NOT NULL,
    CustomerID INT,
    EmployeesID INT,
    OrderDate DATE,
    RequiredDate DATE,
    ShippedDate DATE,
    ShipperVia INT,
    Freight DECIMAL,
    ShipName VARCHAR(20),
    ShipAddress VARCHAR(50),
    ShipCity VARCHAR(50),
    ShipRegion VARCHAR(20),
    ShipPostalCode INT,
    ShipCountry VARCHAR(20),
    PRIMARY KEY(OrderID),
    FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(EmployeesID) REFERENCES Employees(EmployeesID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(ShipperVia) REFERENCES Shippers(ShipperID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS OrderDetails (
    OrderID INT,
    ProductID INT,
    UnitPrice DECIMAL,
    Quantity INT,
    Discount DECIMAL,
    PRIMARY KEY(OrderID, ProductID),
    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(ProductID) REFERENCES Products(ProductID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CustomerDemographics (
    CustomerTypeID INT AUTO_INCREMENT NOT NULL,
    CustomerDesc DECIMAL,
    PRIMARY KEY(CustomerTypeID)
);

CREATE TABLE IF NOT EXISTS Cust_CustDemographics (
    CustomerID INT,
    CustomerTypeID INT,
    PRIMARY KEY(CustomerID, CustomerTypeID),
    FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(CustomerTypeID) REFERENCES CustomerDemographics(CustomerTypeID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Region (
    RegionID INT AUTO_INCREMENT NOT NULL,
    RegionDescription VARCHAR(50),
    PRIMARY KEY(RegionID)
);

CREATE TABLE IF NOT EXISTS Territories (
    TerritoryID INT AUTO_INCREMENT NOT NULL,
    TerritoryDescription VARCHAR(50),
    RegionID INT,
    PRIMARY KEY(TerritoryID),
    FOREIGN KEY(RegionID) REFERENCES Region(RegionID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS EmployeesTerritories (
    EmployeesID INT,
    TerritoryID INT,
    PRIMARY KEY(EmployeesID, TerritoryID),
    FOREIGN KEY(EmployeesID) REFERENCES Employees(EmployeesID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(TerritoryID) REFERENCES Territories(TerritoryID) ON UPDATE CASCADE ON DELETE CASCADE
);