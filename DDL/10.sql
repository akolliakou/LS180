-- Delete the extrasolar database. Use the psql console -- don't use the terminal 
-- level commands.

-- Note: you may want to make a backup of your database before you drop it 
-- (also called a database dump). You can make a backup like this from the 
-- terminal:

-- $ pg_dump --inserts extrasolar > extrasolar.dump.sql

DROP DATABASE extrasolar;
