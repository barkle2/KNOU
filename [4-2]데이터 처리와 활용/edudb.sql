CREATE TABLE customer_info (
  CID char(6),
  Name varchar(20) 		not null,
  Address varchar(100),
  Tel varchar(20),
  Bday date 			not null,
  SID char(14) 			not null,
  Job varchar(20),
  Sex char(1)			not null,
  Married char(1),
  PRIMARY KEY (`CID`)
);

CREATE TABLE customer_onlineinfo (
	CID char(6),
    LID varchar(20) 	not null,
    LPW varchar(20)		not null,
    EMail varchar(20),
    JDay date			not null,
    PRIMARY KEY(CID),
    FOREIGN KEY(CID) REFERENCES customer_info(CID)    
);

CREATE TABLE region (
	RID numeric,
    LRegion varchar(20)	not null,
    SRegion varchar(20)	not null,
    PRIMARY KEY(RID)    
);

CREATE TABLE store (
	SID numeric,
    Name varchar(20) 	not null,
    RID numeric,
    PRIMARY KEY(SID),
    FOREIGN KEY(RID) REFERENCES region(RID)    
);

CREATE TABLE product (
	PID numeric,
    Name varchar(20)	not null,
    Cor varchar(20)		not null,
    UnitPrice numeric	not null,
    Holding	numeric		not null,
    Photo varchar(20),
    PRIMARY KEY(PID)
);

CREATE TABLE sales (
	SaleID	numeric,
    PID numeric,
    SID numeric,
    CID char(6),
    SDay date			not null,
    PRIMARY KEY(SaleID),
    FOREIGN KEY(PID) REFERENCES product(PID),
    FOREIGN KEY(SID) REFERENCES store(SID),
    FOREIGN KEY(CID) REFERENCES customer_info(CID)
);

CREATE TABLE customer_score (
	CID char(6),
    Year numeric,
    On_Score numeric	DEFAULT 0,
    Off_Score numeric	DEFAULT 0,
    PRIMARY KEY(CID, Year),
    FOREIGN KEY(CID) REFERENCES customer_info(CID)
);

LOAD DATA INFILE 'D:\\workspace\\KNOU\\Data Management\\Customer_Info.csv'
INTO TABLE Customer_Info
CHARACTER SET euckr
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'D:\\workspace\\KNOU\\Data Management\\Customer_OnlineInfo.csv'
INTO TABLE Customer_OnlineInfo
CHARACTER SET euckr
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'D:\\workspace\\KNOU\\Data Management\\Region.csv'
INTO TABLE region
CHARACTER SET euckr
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'D:\\workspace\\KNOU\\Data Management\\Store.csv'
INTO TABLE store
CHARACTER SET euckr
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'D:\\workspace\\KNOU\\Data Management\\Product.csv'
INTO TABLE product
CHARACTER SET euckr
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'D:\\workspace\\KNOU\\Data Management\\Sales.csv'
INTO TABLE sales
CHARACTER SET euckr
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'D:\\workspace\\KNOU\\Data Management\\Customer_Score.csv'
INTO TABLE customer_score
CHARACTER SET euckr
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

SELECT * FROM customer_info;
SELECT * FROM customer_onlineinfo;
SELECT * FROM region;
SELECT * FROM store;
SELECT * FROM product;
SELECT * FROM sales;
SELECT * FROM customer_score;

/* 5.(2) */
SELECT CID, Name, Job FROM customer_info;

/* 5.(4) */
SELECT CID, Name, Job, Married FROM customer_info WHERE Job = '회사원';

/* 5.(6) */
SELECT CID
	FROM (SELECT *, On_Score+Off_Score AS TotalScore FROM customer_score WHERE Year=2013) AS Temp
	WHERE TotalScore >= 100 AND TotalScore <= 500;
    
SELECT * 
	FROM customer_info 
    WHERE CID IN (SELECT CID
					FROM (SELECT *, On_Score+Off_Score AS TotalScore FROM customer_score WHERE Year=2013) AS Temp
					WHERE TotalScore >= 100 AND TotalScore <= 500);

/* 5.(8) */
SELECT Job, COUNT(CID) FROM customer_info GROUP BY Job;
  
/* 5.(10) */
SELECT * FROM customer_info 
INNER JOIN customer_onlineinfo
ON customer_info.CID = customer_onlineinfo.CID 
	AND YEAR(customer_info.BDay) >= 1980 AND customer_onlineinfo.EMail IS NOT NULL;