DROP TABLE IF EXISTS alerts_dim; 

CREATE TABLE alerts_dim
(
    id serial PRIMARY KEY,
    tag character varying(20) NOT NULL
);

INSERT INTO alerts_dim 
SELECT 
    row_number() over(), 
    tag
FROM alerts;
