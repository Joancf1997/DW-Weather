DROP TABLE IF EXISTS date_daily_dim;

CREATE TABLE date_daily_dim (
	dateKey int PRIMARY KEY,
	date_day timestamp,
	month VARCHAR,
	quarter VARCHAR,
	year INT,
	dayOfMonth int,
	dayOfYear int,
	monthNum int,
	monthName VARCHAR,
	weekDayNum int,
	weekDayName VARCHAR,
	weekEndDay VARCHAR,
	weekOfYear int,
	quarterOfYear int,
	holidayIndicator VARCHAR,
	holiday VARCHAR
);

INSERT INTO date_daily_dim
SELECT  ROW_NUMBER() OVER () as dateKey, 
		date_trunc('day', day::timestamp) as date_day,
        EXTRACT(year FROM day) || '-' || LPAD(EXTRACT(month FROM day)::VARCHAR, 2, '0') as month,
        EXTRACT(year FROM day) || '-Q' || EXTRACT(quarter FROM day) as quarter,
        EXTRACT(year FROM day) as year,
        EXTRACT(day FROM day) as dayOfMonth, 
        EXTRACT(doy FROM day) as dayOfYear, 
        EXTRACT(month FROM day) as monthNum, 
        (ARRAY['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'])[EXTRACT(month FROM day)] as monthName,
        EXTRACT(isodow FROM day) as weekDayNum,
        (ARRAY['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'])[EXTRACT(isodow FROM day)] as weekDayName,
        CASE WHEN EXTRACT(isodow FROM day) > 5 THEN 'Weekend day' ELSE 'Non-weekend day' END,
        EXTRACT(week FROM day) as weekOfYear,
        EXTRACT(quarter FROM day) as quarterOfYear,
        'Non-holiday' as holidayIndicator,
        NULL as holiday
FROM generate_series('2022-11-10'::date, '2032-12-31'::date, '1 day') AS day; -- generates all days between Nov 4th 2022 to Nov 3th 2023 and populates the date dimension

-- update non-movable holidays
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = 'New Year'  WHERE monthNum = 1 AND dayOfMonth = 1;
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = 'Epiphany' WHERE monthNum = 1 AND dayOfMonth = 6;
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = 'Liberation Day of Italy' WHERE monthNum = 4 AND dayOfMonth = 25;
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = 'Labor Day' WHERE monthNum = 5 AND dayOfMonth = 1;
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = 'Day of the Republic' WHERE monthNum = 6 AND dayOfMonth = 2;
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = 'Assumption Day' WHERE monthNum = 8 AND dayOfMonth = 15;
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = 'All Saints'' Day' WHERE monthNum = 11 AND dayOfMonth = 1;
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = 'Immaculate conception' WHERE monthNum = 12 AND dayOfMonth = 8;
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = '1st Christmas Holiday' WHERE monthNum = 12 AND dayOfMonth = 25;
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = '2nd Christmas Holiday' WHERE monthNum = 12 AND dayOfMonth = 26;
UPDATE date_daily_dim SET holidayIndicator = 'Holiday', holiday = 'New Year''s Eve' WHERE monthNum = 12 AND dayOfMonth = 31;
