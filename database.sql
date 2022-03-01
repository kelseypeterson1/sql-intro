-- Day 1

CREATE TABLE "person" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(100) NOT NULL
);

CREATE TABLE "social-security" (
	"id" SERIAL PRIMARY KEY,
	"person_id" INT REFERENCES "person",
	"number" INT NOT NULL
);

INSERT INTO "person" ("name") VALUES ('Kelsey');
INSERT INTO "social-security" ("person_id", "number") VALUES (1, 12345);

SELECT * FROM "person"
JOIN "social-security" ON "person"."id" = "social-security"."person_id"
WHERE "person"."name" = 'Kelsey';

CREATE TABLE "cohort" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(25),
	"start_date" DATE
);

CREATE TABLE "student" (
	"id" SERIAL PRIMARY KEY,
	"cohort_id" INT REFERENCES "cohort",
	"name" VARCHAR(100) NOT NULL
);

INSERT INTO "cohort" ("name", "start_date") VALUES ('Adams', '11-29-2021');
INSERT INTO "cohort" ("name", "start_date") VALUES ('Butler', '02-28-2021'), ('Xi', '06/06/2016');

INSERT INTO "student" ("cohort_id", "name")
VALUES ('1', 'Mark'), ('1', 'Adam'), ('2', 'Juliette'), ('3', 'Liz');

SELECT * FROM "cohort";
SELECT * FROM "student";

SELECT count(*) FROM "student" 
JOIN "cohort" ON "cohort"."id" = "student"."cohort_id"
WHERE "cohort"."name" = 'Adams';

SELECT count(*) FROM "student" 
JOIN "cohort" ON "cohort"."id" = "student"."cohort_id";

--sum() adds selected fields together

SELECT "cohort"."name", count(*) FROM "student"
JOIN "cohort" ON "cohort"."id" = "student"."cohort_id"
GROUP BY "cohort"."name"
ORDER BY "cohort"."name"; --ASC default, or DESC

INSERT INTO "cohort" ("name") VALUES ('Woodall');

SELECT * FROM "cohort" FULL JOIN "student" on "cohort"."id" = "student"."cohort_id";



-- Day 2

CREATE TABLE "human" (
 	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50)
);

INSERT INTO "human" ("name") VALUES ('Koffi'), ('Liz'), ('Brant'), ('Drew'), ('Andy');

SELECT * FROM "human";

CREATE TABLE "hobby" (
	"id" SERIAL PRIMARY KEY,
	"description" VARCHAR(100)
);

INSERT INTO "hobby" ("description") 
VALUES ('kayaking'), ('drawing'), ('duct tape crafts'), ('tech deck kick flips'), ('cardboard and paper crafts'), ('widdlilng'), ('coding');

CREATE TABLE "human_hobby" (
	"id" SERIAL PRIMARY KEY,
	"human_id" INT REFERENCES "human",
	"hobby_id" INT REFERENCES "hobby",
	"skill" INT
);

INSERT INTO "human_hobby" ("human_id", "hobby_id", "skill")
VALUES (5, 2, 3), (5, 3, 2), (5, 5, 5),
(4, 4, 2), (4, 5, 2), (2, 7, 1), (2, 6, 3),
(3, 2, 2), (3, 6, 1), (3, 5, 3), (1, 7, 2);

SELECT "human"."name", "hobby"."description" AS "fun thing"
FROM "human"
JOIN "human_hobby" ON "human"."id" = "human_hobby"."human_id"
JOIN "hobby" ON "human_hobby"."hobby_id" = "hobby"."id"
WHERE "human"."name" = 'Brant';

SELECT count(*) AS "humans" FROM "human";

SELECT MIN("skill") FROM "human_hobby";

SELECT MAX("skill") FROM "human_hobby";

SELECT ROUND(AVG("skill")), "human"."name"
FROM "human_hobby" 
JOIN "human" ON "human"."id" = "human_hobby"."human_id"
GROUP BY "human"."name";

SELECT SUM("skill") FROM "human_hobby";

SELECT "hobby"."description", count("human_hobby"."hobby_id") AS "the count"
FROM "hobby"
JOIN "human_hobby" ON "hobby"."id" = "human_hobby"."hobby_id"
GROUP BY "hobby"."description"
ORDER BY "the count";

