# ACS-3902--Banking
This database assignment project was assigned in my ACS-3902 Class. I was assigned to analyse and design a simple banking database.
# Conceptual Model
# Relations
Bank (Bank name, Bank number)
Customer (Customer number, First name, Last name, Address, and Telephone number)
Branch (Bank name, Branch number, Address, Phone)
Account(Account number,Balance, Branch Number)

# Relationship Types
- Bank requires Branch.
- Branch requires customers
- Customer requires an account from the branch

# Candidate and Primary Keys
- Bank (**Bank name**, Bank number)
    - Primary key: Bank Name
    - Candidate key: Bank name, Bank number

- Customer (**Customer number**, First name, Last name, Address, and Telephone number)
    - Primary key: Customer number
    - Candidate key: Customer number, telephone number

- Branch (Bank name, **Branch number**, Address, Phone)
    - Primary key: Branch number
    - Candidate key: Branch number, Bank name

- Account(**Account number**,Balance, Branch Number)
    - Primary key: Account number 
    - Candidate key: Account number, Branch Number

# Logical Data Model
**Derived relations from the conceptual model.**
We give each attribute a unique name to prevent data from being misplaced. Additionally, for adjacent one-to-many relationships or zero-to-many relationships we will draw tables for the relations involved. These relations will include the parent keys from adjacent entities.

# Integrity constraints

i. Primary key constraints.
    - Primary keys for each entity cannot be null and must be unique for each value
ii. Referential integrity/Foreign key constraints.
    - If a foreign key contains a value, that value must refer to an existing tuple in the parent relation
iii. Alternate key constraints (if any).
    - No alternate keys were determined as of this implementation

# Normalization
**1NF**
Since tables were determined in the conceptual model, we can represent them in 1NF form

- Bank (Bank name, Bank number)
- Customer (Customer number, First name, Last name, Address, and Telephone number)
- Branch (Bank name, Branch number, Address, Phone)
- Account(Account number, Balance, Branch Number)
- Chequing(Account number, Balance, BranchNum, Overdraft)
- Savings(Account number, Balance, BranchNum, Interest-Rate,)
- Loan(loanNum, Interest-Rate, Balance, BranchNum)

# Functional Dependencies
- bank_name > b_Number
- cust_Num> c_FirstName, c_LastName, c_Address, c_TeleNum
- branch_num, bank_name > b_address, b_phone
- account_num, branch_num> a_Balance
- cheq_accNum, branch_num > c_balance
- sav_accNum, branch_num > s_balance

2NF (Make new tables based on the partial dependencies identified)

No partial dependencies were identified so no new tables are made.
No transitive dependencies were identified so no new tables are made.

Multiple tables have a one-to-many relationships and will have foreign keys.
The relationship tables help to manage entity relationship since they contain the primary keys of their adjacent tables

From the above, we can conlude that our table is already in 3NF form hence we can proceed to the implementation phase of the project.

# Final Implementation
**PostgreSQL Implementation**
**Can be found in the link as well**
CREATE TABLE Bank(
	bankName VARCHAR NOT NULL,
	bankNumber INTEGER NOT NULL,
	PRIMARY KEY (bankName),
	UNIQUE (bankNumber)
);

CREATE TABLE Customer(
	custNum INTEGER NOT NULL,
	Fname VARCHAR NOT NULL,
	Lname VARCHAR NOT NULL,
	PRIMARY KEY(custNum)
);

CREATE TABLE Branch(
	bankName VARCHAR NOT NULL,
	Branch_number INTEGER NOT NULL,
	Address VARCHAR NOT NULL,
	Phone CHAR(10) NOT NULL,
	PRIMARY KEY(Branch_number),
	FOREIGN KEY (bankName) REFERENCES Bank(bankName)
);

-- EERD 1
CREATE TABLE Account(
	accNum VARCHAR(12) NOT NULL,
	balance DECIMAL(12,2) NOT NULL,
	branchNum INTEGER NOT NULL,
	PRIMARY KEY(accNum),
	FOREIGN KEY(branchNum) REFERENCES Branch(Branch_number)
);

CREATE TABLE Chequing(
	accNum VARCHAR(12) NOT NULL,
	balance DECIMAL(12,2) NOT NULL,
	branchNum INTEGER NOT NULL,
	overdraft BIGINT,
	FOREIGN KEY(accNum) REFERENCES Account(accNum)
);

CREATE TABLE Savings(
	accNum VARCHAR(12) NOT NULL,
	balance DECIMAL(12,2) NOT NULL,
	branchNum INTEGER NOT NULL,
	interestRate REAL,
	FOREIGN KEY(accNum) REFERENCES Account(accNum)
);
--end

--EERD 2
CREATE TABLE Loan(
	loanNum INTEGER NOT NULL,
	interestRate REAL,
	balance DECIMAL(12,2) NOT NULL,
	branchNum INTEGER NOT NULL,
	PRIMARY KEY(loanNum),
	FOREIGN KEY(branchNum) REFERENCES Branch(Branch_number)
);

CREATE TABLE Revolving(
	loanNum INTEGER NOT NULL,
	interestRate REAL,
	balance DECIMAL(12,2) NOT NULL,
	branchNum INTEGER NOT NULL,
	FOREIGN KEY(loanNum) REFERENCES Loan(loanNum),
	loanLimit DECIMAL(12,2)
);

CREATE TABLE Credit_Card(
	loanNum INTEGER NOT NULL,
	interestRate REAL,
	balance DECIMAL(12,2),
	branchNum INTEGER,
	FOREIGN KEY(loanNum) REFERENCES Loan(loanNum),
	expiry DATE 
);

CREATE TABLE Line_Of_Credit(
	loanNum INTEGER  NOT NULL,
	interestRate REAL,
	balance DECIMAL(12,2),
	branchNum INTEGER,
	FOREIGN KEY(loanNum) REFERENCES Loan(loanNum)
);

CREATE TABLE Regular(
	loanNum INTEGER NOT NULL,
	interestRate REAL,
	balance DECIMAL(12,2),
	branchNum INTEGER,
	amount DECIMAL(10,2), 
	regDate DATE,
	FOREIGN KEY(loanNum) REFERENCES Loan(loanNum) 
);

CREATE TABLE House(
	loanNum INTEGER NOT NULL,
	interestRate REAL,
	balance DECIMAL(12,2),
	branchNum INTEGER,
	amortization DECIMAL(10,2), 
	address VARCHAR,
	FOREIGN KEY(loanNum) REFERENCES Loan(loanNum) 
);

CREATE TABLE Car(
	loanNum INTEGER NOT NULL,
	interestRate REAL,
	balance DECIMAL(12,2),
	branchNum INTEGER,
	model VARCHAR,
	FOREIGN KEY(loanNum) REFERENCES Loan(loanNum)
);

CREATE TABLE Student(
	loanNum INTEGER NOT NULL,
	interestRate REAL,
	balance DECIMAL(12,2),
	branchNum INTEGER,
	gradYear SMALLINT,
	FOREIGN KEY(loanNum) REFERENCES Loan(loanNum)
);


CREATE TABLE Customer_Account(
	custNum INTEGER NOT NULL,
	accNum VARCHAR(12),
	FOREIGN KEY(custNum) REFERENCES Customer(custNum),
	FOREIGN KEY(accNum) REFERENCES Account(accNum)
);

CREATE TABLE Customer_Loan(
	custNum INTEGER NOT NULL,
	loanNum INTEGER,
	FOREIGN KEY(custNum) REFERENCES Customer(custNum),
	FOREIGN KEY(loanNum) REFERENCES Loan(loanNum)
);

--a
INSERT INTO Customer VALUES(221,'Jay','Bright');

INSERT INTO Bank VALUES('Royal Bank',1);

INSERT INTO Loan VALUES(50,20.0,20000,101);
INSERT INTO Loan VALUES(51,21.0,5000,101);

INSERT INTO Branch VALUES('Royal Bank',101,'1 Pacific Ave','1234567891');

INSERT INTO Student VALUES(50,20.0,20000,101,2022);
INSERT INTO Line_Of_Credit VALUES(51,21.0,5000,101);

INSERT INTO Customer_Loan VALUES(221,50);
INSERT INTO Customer_Loan VALUES(221,51);

--b
INSERT INTO Bank VALUES('TD Bank',2);

INSERT INTO Branch VALUES('TD Bank',102,'3 Pacific Avenue','5432123451');


INSERT INTO Account VALUES('1001',10000,102);
INSERT INTO Chequing VALUES('1001',10000,102,Null);

INSERT INTO Customer_Account VALUES(221,'1001');

--c
INSERT INTO Customer VALUES(222,'Jim','Brigh');

INSERT INTO Branch VALUES('Royal Bank',107,'500 Bairdmore Blvd','1236567891');

INSERT INTO Account VALUES('1002',20000,107);
INSERT INTO Savings VALUES('1002',20000,107,10.0);

INSERT INTO Loan VALUES(53,20.0,400000,107);
INSERT INTO House VALUES(53,20.0,400000,107,25,'2 Sage Creek');

INSERT INTO Customer_Account VALUES(222,'1002');
INSERT INTO Customer_Loan VALUES(222,'53');

--d
INSERT INTO Customer VALUES(223,'Jo','Brig');

INSERT INTO Bank VALUES('RBC',4);
INSERT INTO Bank VALUES('Scotia Bank',3);

INSERT INTO Branch VALUES('Royal Bank',106,'5 Bairdmore Blvd','1239567891');

INSERT INTO Account VALUES('1003',15000,106);
INSERT INTO Savings VALUES('1003',15000,106,5.0);

INSERT INTO Branch VALUES('RBC',110,'100 Pacific Avenue','5432123450');
INSERT INTO Branch VALUES('Scotia Bank',116,'200 Macy Avenue','5432123459');


INSERT INTO Loan VALUES(55,21.0,5000,110);
INSERT INTO Credit_card VALUES(55,21.0,5000,110,'5-03-28');

INSERT INTO Loan VALUES(60,21.0,7000,116);
INSERT INTO Credit_card VALUES(60,21.0,5000,116,'5-04-29');

INSERT INTO Customer_Account VALUES(223,'1003');
INSERT INTO Customer_Loan VALUES(223,'60');
INSERT INTO Customer_Loan VALUES(223,'55');

--e
INSERT INTO Customer VALUES(224,'Joe','Bri');

INSERT INTO Account VALUES('1004',50000,116);
INSERT INTO Chequing VALUES('1004',50000,116,1000);

INSERT INTO Customer_Account VALUES(224,'1004');

--f
SELECT *
FROM Bank;

SELECT *
FROM Customer;

SELECT *
FROM Branch;

SELECT *
FROM Account;

SELECT *
FROM Chequing;

SELECT *
FROM Savings;

SELECT *
FROM Loan;

SELECT *
FROM Revolving;

SELECT *
FROM Regular;

SELECT *
FROM Credit_card;

SELECT *
FROM Line_Of_Credit;

SELECT *
FROM House;

SELECT *
FROM Car;

SELECT *
FROM Student;

SELECT *
FROM Customer_Account;

SELECT *
FROM Customer_Loan;
