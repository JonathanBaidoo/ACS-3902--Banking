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






























