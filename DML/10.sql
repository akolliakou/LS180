-- Our workshop has decided to not make an Accelerometer after all. 
-- Delete any data related to "Accelerometer", this includes the parts 
-- associated with an Accelerometer.

DELETE FROM parts
WHERE device_id = (SELECT id FROM devices WHERE name = 'Accelerometer');

DELETE FROM devices
WHERE name = 'Accelerometer';