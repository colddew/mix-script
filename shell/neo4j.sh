#!/bin/sh
# install neo4j
/Users/tools/neo4j/bin/neo4j console

# start neo4j and browse http://127.0.0.1:7474/
/Users/tools/neo4j/bin/neo4j start
:server connect
:help
:history

# Cypher Pattern
# (n)-[r:TYPE1|TYPE2]→()
# (variable:Label)-[variable:Label{propertiesKey:propertiesValue}]->(variable:Label)

# example
CREATE (ee:Person { name: "Emil", from: "Sweden", klout: 99 })
MATCH (ee:Person)-[:KNOWS]-(friends) WHERE ee.name = "Emil" RETURN ee, friends
MATCH (js:Person)-[:KNOWS]-()-[:KNOWS]-(surfer) WHERE js.name = "Johan" AND surfer.hobby = "surfing" RETURN DISTINCT surfer
PROFILE MATCH (js:Person)-[:KNOWS]-()-[:KNOWS]-(surfer) WHERE js.name = "Johan" AND surfer.hobby = "surfing" RETURN DISTINCT surfer
EXPLAIN MATCH (js:Person)-[:KNOWS]-()-[:KNOWS]-(surfer) WHERE js.name = "Johan" AND surfer.hobby = "surfing" RETURN DISTINCT surfer
MATCH (people:Person)-[relatedTo]-(:Movie {title: "Cloud Atlas"}) RETURN people.name, Type(relatedTo), relatedTo
MATCH (bacon:Person {name:"Kevin Bacon"})-[*1..4]-(hollywood) RETURN DISTINCT hollywood
MATCH p=shortestPath((bacon:Person {name:"Kevin Bacon"})-[*]-(meg:Person {name:"Meg Ryan"})) RETURN p
MATCH (tom:Person {name:"Tom Hanks"})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(coActors), (coActors)-[:ACTED_IN]->(m2)<-[:ACTED_IN]-(cocoActors) WHERE NOT (tom)-[:ACTED_IN]->(m2) RETURN cocoActors.name AS Recommended, count(*) AS Strength ORDER BY Strength DESC
MATCH (tom:Person {name:"Tom Hanks"})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(coActors), (coActors)-[:ACTED_IN]->(m2)<-[:ACTED_IN]-(cruise:Person {name:"Tom Cruise"}) RETURN tom, m, coActors, m2, cruise
MATCH (a:Person),(m:Movie) OPTIONAL MATCH (a)-[r1]-(), (m)-[r2]-() DELETE a,r1,m,r2
MATCH (n) RETURN n
CREATE INDEX ON :Product(productID)
MATCH (p:Product),(c:Category) WHERE p.categoryID = c.categoryID CREATE (p)-[:PART_OF]->(c)
MATCH (s:Supplier)-->(:Product)-->(c:Category) RETURN s.companyName as Company, collect(distinct c.categoryName) as Categories
CALL db.schema()
