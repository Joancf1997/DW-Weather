DROP TABLE IF EXISTS continent;

CREATE TABLE continent
(
    id serial PRIMARY KEY,
    name character varying(7) NOT NULL
);

COMMENT ON TABLE continent
    IS 'Table of continents.';

insert into continent (name)
values ('Asia'), 
	   ('America'), 
	   ('Europe'), 
	   ('Africa'), 
	   ('Oceania');
