DROP TABLE IF EXISTS alerts;

CREATE TABLE alerts
(
    id serial PRIMARY KEY,
    tag character varying(20) NOT NULL
);

COMMENT ON TABLE alerts
    IS 'Table of API Alerts.';

insert into alerts (tag)
values ('None'), 
	   ('Thunderstorm'), 
	   ('Drizzle'), 
	   ('Rain'), 
	   ('Snow'),
	   ('Atmosphere'), 
	   ('Clear'), 
	   ('Clouds'),
	   ('Other'),
	   ('Wind');
