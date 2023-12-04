DROP TABLE IF EXISTS country;

CREATE TABLE country
(
    id serial PRIMARY KEY,
    name character varying(50) NOT NULL,
    acronym character varying(3) NOT NULL,
    id_continent smallint NOT NULL,
	FOREIGN KEY (id_continent) REFERENCES Continent(id)
);

COMMENT ON TABLE country
    IS 'Table of countries.';

insert into country (name, acronym, id_continent)
values ('Italy', 'IT', 3), 
	   ('Germany', 'GER', 3),
	   ('United Stated of America', 'USA', 2),
	   ('Mexico', 'MEX', 2),
	   ('Jamaica', 'JAM', 2),
	   ('Brazil', 'BRA', 2),
	   ('Argentina', 'ARG', 2),
	   ('Islandia', 'ISL', 3),
	   ('Portugal', 'POR', 3),
	   ('Zimbabue', 'ZIM', 4),
	   ('Tailandia', 'TAI', 1),
	   ('Afganistan', 'AFG', 1),
	   ('Rusia', 'RUS', 3),
	   ('New Zeland', 'NZE', 5),
	   ('Tonga', 'TON', 5),
	   ('Finland', 'FIN', 3),
	   ('Argelia', 'ARL', 4);
