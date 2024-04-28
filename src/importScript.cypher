CREATE CONSTRAINT ON (p:Person) ASSERT p.employeeID IS UNIQUE;
CREATE CONSTRAINT ON (i:Item) ASSERT i.itemID IS UNIQUE;
CREATE CONSTRAINT ON (t:Transaction) ASSERT t.transactionID IS UNIQUE;
CREATE CONSTRAINT ON (p:Period) ASSERT p.period IS UNIQUE;
CREATE INDEX ON :Item(price);
CREATE INDEX ON :Item(wholesalePrice);

//
WITH range(1,52) as periods
FOREACH (period IN periods |
  MERGE (p:Period {period:period}));

//
MATCH (p:Period)
WITH p
ORDER BY p.period
WITH COLLECT(p) as periods
FOREACH (i IN RANGE(0, size(periods)-2) |
  FOREACH(p1 IN [periods[i]] |
      FOREACH(p2 IN [periods[i+1]] |
          CREATE (p1)-[:NEXT]->(p2))));

//
LOAD CSV WITH HEADERS FROM "https://github.com/FuuToru/Neo4J_MLM/blob/main/src/item.csv" as line
WITH line,
  toInteger(line.item) as itemID,
  toFloat(line.price) as price,
  toFloat(line.kicker) as kick,
  toFloat(line.wprice) as wholesale
CREATE (:Item {itemID:itemID, name:line.name, price:price, kicker:kick, wholesalePrice:wholesale});

//
LOAD CSV WITH HEADERS FROM "https://github.com/FuuToru/Neo4J_MLM/blob/main/src/employees.csv" as line
WITH line, toInteger(line.employeeID) as empID
CREATE (:Person {employeeID:empID, name:line.name});

//
LOAD CSV WITH HEADERS FROM "https://github.com/FuuToru/Neo4J_MLM/blob/main/src/employees.csv" as line
WITH line, toInteger(line.employeeID) as empID, toInteger(line.reportsTo) as reportsToID
MATCH (sub:Person {employeeID: empID}), (boss:Person {employeeID: reportsToID})
MERGE (sub)-[:REPORTS_TO]->(boss);

//
LOAD CSV WITH HEADERS FROM "https://github.com/FuuToru/Neo4J_MLM/blob/main/src/transactions.csv" as line
WITH line, toInteger(line.transactionID) as transID
CREATE (:Transaction {transactionID:transID});

//
LOAD CSV WITH HEADERS FROM "https://github.com/FuuToru/Neo4J_MLM/blob/main/src/transactions.csv" as line
WITH line, toInteger(line.transactionID) as transID, toInteger(line.period) as period
MATCH (t:Transaction {transactionID: transID}), (p:Period {period: period})
CREATE (t)-[:OCCURRED_IN]->(p);

//
LOAD CSV WITH HEADERS FROM "https://github.com/FuuToru/Neo4J_MLM/blob/main/src/transactions.csv" as line
WITH line,
  toInteger(line.transactionID) as transID,
  toInteger(line.item1) as itemID1,
  toInteger(line.item2) as itemID2,
  toInteger(line.item3) as itemID3
MATCH (tx:Transaction {transactionID: transID}),
      (i1:Item {itemID: itemID1}),
      (i2:Item {itemID: itemID2}),
      (i3:Item {itemID: itemID3})
CREATE (tx)-[:CONTAINS]->(i1),
       (tx)-[:CONTAINS]->(i2),
       (tx)-[:CONTAINS]->(i3);

//
LOAD CSV WITH HEADERS FROM "https://github.com/FuuToru/Neo4J_MLM/blob/main/src/transactions.csv" as line
WITH line,
  toInteger(line.transactionID) as transID,
  toInteger(line.salesRepID) as repID
MATCH (rep:Person {employeeID: repID}),
      (tx:Transaction {transactionID: transID})
CREATE (rep)-[:SOLD]->(tx);

//
MATCH (target:Person)<-[r:REPORTS_TO*..]-(e)
WITH target, count(e) as totalReports
SET target.reportsCount = totalReports
WITH target,

//setting the right "level" based on number of reports
CASE
WHEN target.reportsCount > 124
THEN 6
WHEN target.reportsCount < 124 and target.reportsCount >= 75
THEN 5
WHEN target.reportsCount < 75 and target.reportsCount >= 25
THEN 4
WHEN target.reportsCount < 25 and target.reportsCount >= 10
THEN 3
WHEN target.reportsCount < 10 and target.reportsCount >= 2
THEN 2
ELSE 1
END AS levels
SET target.level = levels;