# Neo4J_MLM
### Basic summary
![diagram](./image/img1.png)
- Neo4j is a graph database. True to its name, data is organized in the form of a graph, where each data object is stored as a node in the graph. These nodes are often labeled to differentiate between different types of nodes. The relationships between nodes are represented as edges, expressing the connections between the objects.

- As the image, we can see:
    - Node: In a graph database, a node can store information in JSON and is assigned a label to distinguish it type, aiding algorithms and queries.

    - Relationship: These are edges in a graph database, representing the connections between nodes. These relationships can have additional values ( in JSON format) attached to them. Relationsships play a crucial role in querying and utilizing algorithms.
- In the graph, data about entities ( such as products, users, etc.) is represented boy nodes.

- Meanwhile, relationships are deepicted by various types of lines: --->, ----, <---, to represent relationships. Here, you can assign weights to relationships(ex: A--[friends:5]-->B, A--[friends:15]-->C) indicating that the friendship between A and B is rated 5, and between A and C is rated 15.
