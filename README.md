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
**PostgreSQL Implementation included in link bankDB.sql.**

