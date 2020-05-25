CREATE USER 'testUser'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON USAirlineFlights2.* TO 'testUser'@'localhost';

/* Refrescar privilegis */
FLUSH PRIVILEGES;