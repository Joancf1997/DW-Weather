DROP TABLE IF EXISTS weather_class_dim; 

CREATE TABLE weather_class_dim
(
    id smallint NOT NULL PRIMARY KEY,
    main character varying(20) NOT NULL,
    description character varying(40) NOT NULL
);
    

INSERT INTO weather_class_dim
SELECT 
    id, 
    main,
    description
FROM weather_alerts;
