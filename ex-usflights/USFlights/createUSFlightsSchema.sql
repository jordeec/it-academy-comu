DROP SCHEMA IF EXISTS USAirlineFlights2;
CREATE DATABASE IF NOT EXISTS USAirlineFlights2;
use USAirlineFlights2;

CREATE TABLE USAirports (
	IATA			VARCHAR(32) NOT NULL PRIMARY KEY,
	Airport			VARCHAR(80),
	City			VARCHAR(32),
	State			VARCHAR(32),
	Country			VARCHAR(32),
	Latitude		FLOAT,
	Longitude		FLOAT);
    
CREATE TABLE Carriers (
	CarrierCode		VARCHAR(32) NOT NULL PRIMARY KEY,
	Description		VARCHAR(120)
);

CREATE TABLE IF NOT EXISTS Flights(
	flightID		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	colYear			SMALLINT,
	colMonth		SMALLINT,
    DayOfMonths		SMALLINT,
	DayOfWeek		SMALLINT,
	DepTime			SMALLINT,
	CRSDepTime		SMALLINT,
	ArrTime			SMALLINT,
	CRSArrTime		SMALLINT,
	UniqueCarrier	VARCHAR(32),
	FlightNum		VARCHAR(32),
	TailNum			VARCHAR(32),
	ActualElapsedTime SMALLINT,
	CRSElapsedTime	SMALLINT,
	AirTime			SMALLINT,
	ArrDelay		SMALLINT,
	DepDelay		SMALLINT,
	Origin			VARCHAR(32),
	Dest			VARCHAR(32),
	Distance		SMALLINT,
	TaxiIn			SMALLINT,
	TaxiOut			SMALLINT,
	Cancelled		BOOLEAN,
	CancellationCode VARCHAR(32),
	Diverted		BOOLEAN,
    
    FOREIGN KEY (Dest)
		REFERENCES USAirports (IATA),
        
	FOREIGN KEY (Origin)
		REFERENCES USAirports (IATA),
        
	FOREIGN KEY (UniqueCarrier)
		REFERENCES Carriers (CarrierCode)
);