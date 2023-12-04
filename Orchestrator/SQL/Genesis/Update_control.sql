DROP TABLE IF EXISTS update_control;

create table update_control
(
	id serial PRIMARY KEY,
	last_source_id int NOT NULL,
	last_timestamp timestamp NOT NULL
);

COMMENT ON TABLE update_control
    IS 'Control of all the updates to the dim tables';
	
-- Ijnsert startint point (first datapoint)
insert into update_control (last_source_id, last_timestamp)
values (0, '1997-10-12 19:33:06');
