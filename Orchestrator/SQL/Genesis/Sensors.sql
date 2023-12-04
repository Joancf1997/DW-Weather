DROP TABLE IF EXISTS sensors;

CREATE TABLE sensors
(
    id serial PRIMARY KEY,
    name character varying(3) NOT NULL
);

COMMENT ON TABLE sensors
    IS 'Table of sensors.';


insert into sensors (name)
values ('APT'), 
	   ('SMT'), 
	   ('RK'), 
	   ('PMT');
