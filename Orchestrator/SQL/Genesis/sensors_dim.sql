DROP TABLE IF EXISTS sensors_dim; 

CREATE TABLE sensors_dim
(
    id serial PRIMARY KEY,
    name character varying(3) NOT NULL
);

   
INSERT INTO sensors_dim
SELECT 
    id, 
    name
FROM sensors;
