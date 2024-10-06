-- 2024-08-31 9:38PM EEST 
-- [Executed] - Query returned successfully in 421 msec. 
CREATE DATABASE p1dp_online_retail_app
    ENCODING UTF8;

-- 2024-08-31 9:51PM EEST
-- [Executed]
CREATE USER p1dp_ora_dba
	WITH PASSWORD ''; -- Use your own password 

-- 2024-08-31 9:52PM EEST
-- [Executed]
GRANT ALL PRIVILEGES ON SCHEMA public TO p1dp_ora_dba;