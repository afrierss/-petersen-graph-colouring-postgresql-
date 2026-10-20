# Graph Colouring of the Petersen Graph with PostgreSQL

## The Petersen Graph

The [Petersen graph](https://en.wikipedia.org/wiki/Petersen_graph) has 10 vertices and 15 edges. Two connected vertices must have different colours. Three colours are enough to colour the graph.
I also attach a Petersen Graph.

## SQL

I first checked two colourings that I had created manually.

Then I generated all possible assignments of six colours to the ten vertices. This gave 60466176 possible assignments. After removing the invalid ones, 3868080 valid colourings remained.

I counted how many colours were used in each colouring.

## Results

| Colours used | Number of colourings |
|---:|---:|
| 3 | 2400 |
| 4 | 187200 |
| 5 | 1615680 |
| 6 | 2062800 |
| **Total** | **3868080** |

## Checking the Results with Combinatorics

We can also check the SQL results with combinatorics.

According to Peter Cameron's explanation of graph colourings, there are 20 ways to divide the vertices of the Petersen graph into three colour groups.

Link: https://cameroncounts.wordpress.com/2012/04/12/counting-colourings-of-graphs/ Each group gets a different colour. We can choose three colours from our six colour scheme and assign them to the groups in 6 × 5 × 4 ways. This gives 20 × 6 × 5 × 4 = 2400 colourings.

The same calculation works for four, five and six colours:

| Colours used | Number of colour groups | Calculation | Result |
|---:|---:|---|---:|
| 3 | 20 | 20 × 6 × 5 × 4 | 2400 |
| 4 | 520 | 520 × 6 × 5 × 4 × 3 | 187200 |
| 5 | 2244 | 2244 × 6 × 5 × 4 × 3 × 2 | 1615680 |
| 6 | 2865 | 2865 × 6! | 2062800 |

All four results match the SQL counts. Since the graph needs at least three colours and can be coloured with three, its chromatic number is three.

## Next Steps

I want to improve the search so that SQL does not have to generate all possible assignments first. I also want to continue working on my recursive SQL approach, which does not work correctly yet.

I want to find a minimum colouring with SQL and check the results with Python. I would also like to compare the execution times of the different approaches.
