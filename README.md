# Neo4J_MLM
### Basic summary
![diagram](./image/img1.png)
- Neo4j is a graph database. True to its name, data is organized in the form of a graph, where each data object is stored as a node in the graph. These nodes are often labeled to differentiate between different types of nodes. The relationships between nodes are represented as edges, expressing the connections between the objects.

- As the image, we can see:
    - Node: In a graph database, a node can store information in JSON and is assigned a label to distinguish it type, aiding algorithms and queries.

    - Relationship: These are edges in a graph database, representing the connections between nodes. These relationships can have additional values ( in JSON format) attached to them. Relationsships play a crucial role in querying and utilizing algorithms.
- In the graph, data about entities ( such as products, users, etc.) is represented boy nodes.

- Meanwhile, relationships are deepicted by various types of lines: --->, ----, <---, to represent relationships. Here, you can assign weights to relationships(ex: A--[friends:5]-->B, A--[friends:15]-->C) indicating that the friendship between A and B is rated 5, and between A and C is rated 15.

- As a graph database, Neo4j is commonly used to describe information networks such as social networks, sensor networks, etc. Where data is represented as entities (nodes) on a directed graph.

### What is Neo4j ?

- Neo4j is a graph database.

- In relational databases like SQL Server, MySQL, or Oracle, an entity like "MonHoc" (subject) with its properties is described using a table consisting of multiple columns, where the table name represents the entity and the columns describe the properties of the entity. Relationships between entities are built by recording the information of the parent entity into the child entity.

- In Neo4j, entities are represented as vertices (nodes) of the graph, where the properties of the entity are described through the attributes of the node. The relationships between entities are depicted by links between nodes.

- As a graph database, Neo4j's storage model, storage structure, and object characteristics are tailored for graph databases in general. This means that Neo4j stores data on nodes and constructs various data structures using relationships.

### Application

- Neo4j, as a graph database, is commonly used to describe information networks such as social networks, sensor networks,etc. where data is represented as entities (vertices) on a directed graph.
![diagram2](./image/img2.png)

### Node

- Nodes are commonly used to represent entities. The simplest graph is one where there is only one node.

### Label

- Labels can be used to model the domain of values for nodes, typically grouping nodes with the same data type or property into a set and then assigning labels to them.

- For example, all nodes representing a user object can be labeled as "Users". Then, you can conveniently work with Neo4j through these labeled nodes, such as finding all users with a name matching "ABC".

- Each node can have one or more labels. To represent different dimensions of data, you can add labels to nodes accordingly.

### Properties

- Simple put, nodes and relationships can both have data written onto them( in JSON format). In theory:
        - Properties are a name-values pair used to represent attributes of nodes as well as relationships. Properties can store various data types such as number, string, and boolean with corresponding value domains.

### Query Language Cypher

- Similar to the SQL

![img1](./image/img3.png)

example:
    - create node:
    ![img2](./image/img4.png)
    - create relationship:
    ![img3](./image/img5.png)
    - MATCH (userV:USER), (cityHCM:LOCATION) WHERE userV.username = 'VinhRikin' AND cityHCM.name = 'HCM' CREATE (userV)-[r:LIVE {value: 4}]->(cityHCM) RETURN r
    ![img4](./image/img6.png)

### Algorithm groups

![img5](./image/img7.png)

### Summary

- Through the article, we've learned about Neo4j, including what it is, it's basic objects, querying methods, and a quick overview of algorithms. Have a great day !








