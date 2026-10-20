I) CHECK MANUAL COLOURINGS

CREATE TABLE petersen."KnotenfarbeZugeordnet1" AS
SELECT
    k."Knoten1",
    f1."Farbe" AS "Farbeknoten1",
    k."Knoten2",
    f2."Farbe" AS "Farbeknoten2"
FROM petersen."Petersen" k
INNER JOIN petersen."Färbung1" f1
    ON k."Knoten1" = f1."Knoten"
INNER JOIN petersen."Färbung1" f2
    ON k."Knoten2" = f2."Knoten";


CREATE TABLE petersen."KnotenfarbeZugeordnet2" AS
SELECT
    k."Knoten1",
    f1."Farbe" AS "Farbeknoten1",
    k."Knoten2",
    f2."Farbe" AS "Farbeknoten2"
FROM petersen."Petersen" k
INNER JOIN petersen."Färbung2" f1
    ON k."Knoten1" = f1."Knoten"
INNER JOIN petersen."Färbung2" f2
    ON k."Knoten2" = f2."Knoten";


CREATE TABLE petersen."Farbpassung1" AS
SELECT j."Farbeknoten1", j."Farbeknoten2"
FROM petersen."KnotenfarbeZugeordnet1" j
WHERE NOT j."Farbeknoten1" = j."Farbeknoten2";


CREATE TABLE petersen."Farbpassung2" AS
SELECT j."Farbeknoten1", j."Farbeknoten2"
FROM petersen."KnotenfarbeZugeordnet2" j
WHERE NOT j."Farbeknoten1" = j."Farbeknoten2";

II) GENERATE COLOURINGS

CREATE TABLE petersen."Mix" AS
SELECT s."Farbe" AS "FarbeKnoten1",
t."Farbe" AS "Farbeknoten2"
FROM petersen."Farbe" s
CROSS JOIN petersen."Farbe" t;

CREATE TABLE petersen."Mixgroß" AS
SELECT s."Farbe" AS "FarbeKnoten1",
t."Farbe" AS "Farbeknoten2",
u."Farbe" AS "Farbeknoten3",
v."Farbe" AS "Farbeknoten4",
w."Farbe" AS "Farbeknoten5",
x."Farbe" AS "Farbeknoten6",
y."Farbe" AS "Farbeknoten7",
z."Farbe" AS "Farbeknoten8",
a."Farbe" AS "Farbeknoten9",
b."Farbe" AS "Farbeknoten10"
FROM petersen."Farbe" s
CROSS JOIN petersen."Farbe" t
CROSS JOIN petersen."Farbe" u
CROSS JOIN petersen."Farbe" v
CROSS JOIN petersen."Farbe" w
CROSS JOIN petersen."Farbe" x
CROSS JOIN petersen."Farbe" y
CROSS JOIN petersen."Farbe" z
CROSS JOIN petersen."Farbe" a
CROSS JOIN petersen."Farbe" b;


CREATE TABLE petersen."MixGültig" AS
SELECT a. "Farbeknoten1",
a. "Farbeknoten2",
 a. "Farbeknoten3",
 a. "Farbeknoten4",
 a. "Farbeknoten5",
 a. "Farbeknoten6",
 a. "Farbeknoten7",
 a. "Farbeknoten8",
 a. "Farbeknoten9",
 a. "Farbeknoten10"
FROM petersen."Mixgroß" a
WHERE NOT 
(a."Farbeknoten1"= a."Farbeknoten6")
AND NOT (a."Farbeknoten1"= a."Farbeknoten2")
AND NOT (a."Farbeknoten2"= a."Farbeknoten7")
AND NOT (a."Farbeknoten2"= a."Farbeknoten3")
AND NOT (a."Farbeknoten3"= a."Farbeknoten8")
AND NOT (a."Farbeknoten3"= a."Farbeknoten4")
AND NOT (a."Farbeknoten4"= a."Farbeknoten9")
AND NOT (a."Farbeknoten4"= a."Farbeknoten5")
AND NOT (a."Farbeknoten5"= a."Farbeknoten10")
AND NOT (a."Farbeknoten5"= a."Farbeknoten1")
AND NOT (a."Farbeknoten6"= a."Farbeknoten8")
AND NOT (a."Farbeknoten6"= a."Farbeknoten9")
AND NOT (a."Farbeknoten7"= a."Farbeknoten9")
AND NOT (a."Farbeknoten7"= a."Farbeknoten10")
AND NOT (a."Farbeknoten8"= a."Farbeknoten10");

III) COUNT COLOURINGS

CREATE TABLE petersen."AnzahlDerLösungen" AS
SELECT COUNT (*)
FROM petersen."MixGültig";

CREATE TABLE petersen."LösungenGegliedert" AS
SELECT a.*,
       f."FarbeProLösunginSpalten"
FROM petersen."MixGültig" a,
UNNEST(ARRAY[
    a."Farbeknoten1", a."Farbeknoten2",
    a."Farbeknoten3", a."Farbeknoten4",
    a."Farbeknoten5", a."Farbeknoten6",
    a."Farbeknoten7", a."Farbeknoten8",
    a."Farbeknoten9", a."Farbeknoten10"
]) AS f("FarbeProLösunginSpalten");

CREATE TABLE petersen."AnzahlDerLösungenProFarbanzahl" AS
SELECT
    "Farbeknoten1", "Farbeknoten2", "Farbeknoten3",
    "Farbeknoten4", "Farbeknoten5", "Farbeknoten6",
    "Farbeknoten7", "Farbeknoten8", "Farbeknoten9",
    "Farbeknoten10",
    COUNT(DISTINCT "FarbeProLösunginSpalten") AS "AnzahlFarben"
FROM petersen."LösungenGegliedert"
GROUP BY
    "Farbeknoten1", "Farbeknoten2", "Farbeknoten3",
    "Farbeknoten4", "Farbeknoten5", "Farbeknoten6",
    "Farbeknoten7", "Farbeknoten8", "Farbeknoten9",
    "Farbeknoten10";

CREATE TABLE petersen."LösungenNachFarbzahl" AS
SELECT a."AnzahlFarben", COUNT(*) AS "AnzahlFinal"
FROM petersen."AnzahlDerLösungenProFarbanzahl" a
GROUP BY a."AnzahlFarben";





