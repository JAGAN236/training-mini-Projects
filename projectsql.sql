create database Project;
use Project;

create table  Customer (
       CustomerId int primary key,
       Name varchar(50) not null,
       Address varchar(100) not null,
	   PhoneNumber varchar(10) not null,
       Email varchar(50) unique
       );
       
insert into Customer values(1, 'ali basha', 'tirupati', '9000012345', 'ali401@gmail.com'),
						   (2, 'harsha', 'chennai', '9002647859', 'harsha402@gmail.com'),
						   (3, 'bharath', 'hyderabad', '8749578912', 'bharath403@gmail.com'),
						   (4, 'jagan', 'tirupati', '7895674983', 'jagan404@gmail.com'),
						   (5, 'praneeth', 'bengaluru', '9089786950', 'praneeth405@gmail.com');



create table  Meter  (
            MeterId int primary key,
            CustomerId int,
			InstallationDate date not null,
            LastreadingDate  date not null,
            constraint fk_customer
			foreign key (CustomerId) 
            references Customer(CustomerId)
            on delete cascade                    -- If a customer is deleted, their meters are also deleted
            );

insert into Meter values(101,1,"2025-10-10","2025-11-10"),
						(102,2,"2025-09-01","2025-10-01"),
						(103,3,"2025-09-15","2025-10-15"),
						(104,4,"2025-08-10","2025-09-10"),
						(105,5,"2025-05-22","2025-06-22");
					     

						
 create table ElectricityUsage(
					UsageId int primary key,
					MeterId int,
                    ReadingDate date not null,
                    UsageUnits numeric(10,2) not null ,
                    constraint usageunit check (UsageUnits >= 0),
                    constraint fk_MeterId                        -- If MeterId is deleted, their ElectricityUsage are also deleted
                    foreign key (MeterId)
                    references Meter(MeterId)
                    on delete cascade
					);
                    
insert into ElectricityUsage values(1001, 101, '2025-11-10', 250.00),         
                                   (1002, 102, '2025-10-01', 320.50),
                                   (1003, 103, '2025-10-15', 180.00),   
								   (1004, 104, '2025-09-10', 400.25),   
                                   (1005, 105, '2025-06-22', 275.00);   

                                   


create table Bill (
				 BillId int primary key,
				 MeterId int ,
				 BillDate date not null,
				 AmountDue numeric(10,2) ,
				 DueDate date not null,
                 Paid tinyint not null default 0,
                 constraint Amountdue check (AmountDue >= 0),       -- the Amountdue should be always positive
                 constraint MeterId_fk 
                 foreign key (MeterId)                            -- If MeterId is deleted, their Bill are also deleted
                 references Meter(MeterId)
                 on delete cascade
                  );

insert into Bill values (2001, 101, '2025-11-11', 1250.50, '2025-11-15', 0), 
                        (2002, 102, '2025-10-02', 980.00, '2025-10-16', 1),  
					    (2003, 103, '2025-10-16', 1430.75, '2025-10-25', 0),
					    (2004, 104, '2025-09-11', 760.25, '2025-09-18', 1), 
                        (2005, 105, '2025-06-23', 1120.00, '2025-06-28', 0); 



create table Payment(
                   PaymentId int primary key,
				   BillId int,
				   PaymentDate date not null,
				   AmountPaid numeric(10,2),
                   constraint amountpaid check(AmountPaid >=0 ),
                   constraint BillId_fk
                   foreign key (BillId)
                   references Bill(BillId)
                   on delete cascade
                     );
                     
insert into Payment Values(3001, 2001, '2025-11-12', 1250.50),  
						  (3002, 2002, '2025-10-10', 980.00),    
                          (3003, 2003, '2025-10-20', 1430.75),  
						  (3004, 2004, '2025-09-15', 760.25),   
						  (3005, 2005, '2025-06-25', 1120.00); 
                          
						
select*from Customer;
select*from Meter;
select*from ElectricityUsage;
select*from Bill;
select*from Payment;

select MeterId,SUM(UsageUnits) as TotalUsage
from ElectricityUsage
group by MeterId
having SUM(UsageUnits) > 200;


select c.CustomerId,c.Name as CustomerName,
SUM(b.AmountDue) as TotalUnpaidAmount
from Customer c
join Meter m on c.CustomerId = m.CustomerId
join Bill b on m.MeterId = b.MeterId
where b.Paid = 0
group by c.CustomerId, c.Name
order by TotalUnpaidAmount desc;


select b.BillId, b.MeterId, b.BillDate,
case when b.Paid = 1 then'Paid' else 'Unpaid' end as PaymentStatus
from Bill b
order by b.BillDate asc;

select distinct c.CustomerId, c.Name
FROM Customer c
JOIN Meter m ON c.CustomerId = m.CustomerId
WHERE m.InstallationDate > '2023-12-31';

select m.MeterId, m.LastReadingDate, 
SUM(eu.UsageUnits) as TotalUsage
from Meter m
join ElectricityUsage eu on m.MeterId = eu.MeterId
group by m.MeterId, m.LastReadingDate
order by TotalUsage desc;

















