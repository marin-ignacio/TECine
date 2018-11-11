-- Database: TECine

-- DROP DATABASE "TECine";

CREATE DATABASE "TECine"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Spain.1252'
    LC_CTYPE = 'Spanish_Spain.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
CREATE TABLE Director(
	_ID 		INT 			NOT NULL,
	_FName 		VARCHAR(40) 	NOT NULL,
	_LName		VARCHAR(200) 	NOT NULL,
	PRIMARY KEY(_ID)
) ;

CREATE TABLE Actor(
	_ID 		INT 			NOT NULL,
	_FName		VARCHAR(40) 	NOT NULL,
	_LName		VARCHAR(200)	NOT NULL,
	PRIMARY KEY(_ID)
) ;
				
CREATE TABLE Gender(
	_ID 		INT 			NOT NULL,
	_Name 		VARCHAR(40) 	NOT NULL,
	PRIMARY KEY(_ID)
) ;

CREATE TABLE Movie(
	_ID 			INT 			NOT NULL,
	_Title 			VARCHAR(40) 	NOT NULL,
	_Duration_min 	INT 			NOT NULL,
	_Description	VARCHAR(200) 	NOT NULL,
	_Image			BYTEA			NOT NULL,

	PRIMARY KEY(_ID)
) ;

CREATE TABLE Directors_per_Movie(
	_Director_ID 	INT 		NOT NULL,
	_Movie_ID 		INT 		NOT NULL,
	PRIMARY KEY(_Director_ID,_Movie_ID)
) ;

CREATE TABLE Actors_per_Movie(
	_Actor_ID 		INT 		NOT NULL,
	_Movie_ID 		INT 		NOT NULL,
	PRIMARY KEY(_Actor_ID,_Movie_ID)
) ;

CREATE TABLE Genders_per_Movie(
	_Gender_ID 		INT 		NOT NULL,
	_Movie_ID 		INT 		NOT NULL,
	PRIMARY KEY(_Gender_ID,_Movie_ID)
) ;
				
CREATE TABLE Cinema(
	_ID 			INT 		NOT NULL,
	_Name 			VARCHAR(40) NOT NULL,
	_Location 		VARCHAR(40) NOT NULL,
	PRIMARY KEY(_ID)
) ;
				
CREATE TABLE Auditorium(
	_ID 			INT 		NOT NULL,
	_Name 			VARCHAR(40) NOT NULL,
	PRIMARY KEY(_ID)
) ;
				
CREATE TABLE Seat(
	_ID 	INT 	NOT NULL,
	_Row 	CHAR 	NOT NULL,
	_Number INT 	NOT NULL,
	PRIMARY KEY(_ID)
) ;
				
CREATE TABLE Auditoriums_per_Cinema(
	_Auditorium_ID 	INT 	NOT NULL,
	_Cinema_ID 		INT 	NOT NULL,
	PRIMARY KEY(_Auditorium_ID,_Cinema_ID)
) ;
				
CREATE TABLE Seats_per_Auditorium(
	_Auditorium_ID 	INT 	NOT NULL,
	_Seat_ID 		INT 	NOT NULL,
	PRIMARY KEY(_Auditorium_ID,_Seat_ID)
) ;
				
CREATE TABLE Screening(
	_ID 			INT 	NOT NULL,
	_Cinema_ID 		INT 	NOT NULL,
	_Auditorium_ID 	INT 	NOT NULL,
	_Movie_ID 		INT 	NOT NULL,
	_Date 			DATE 	NOT NULL,
	_Start_time 	TIME 	NOT NULL,
	PRIMARY KEY(_ID)
) ;
				
CREATE TABLE Reservation(
	_ID 			INT 	NOT NULL,
	_Screening_ID 	INT 	NOT NULL,
	_Active 		BOOL 	NOT NULL, 
	PRIMARY KEY(_ID)
);
				
CREATE TABLE Seats_Reserved(
	_Reservation_ID INT	 NOT NULL,
	_Seat_ID 		INT	 NOT NULL,
	PRIMARY KEY(_Reservation_ID,_Seat_ID)
) ;
				
ALTER TABLE Directors_per_Movie ADD FOREIGN KEY(Director_ID) REFERENCES Director(_ID);
ALTER TABLE Directors_per_Movie ADD FOREIGN KEY(Movie_ID) REFERENCES Movie(_ID);

ALTER TABLE Actors_per_Movie ADD FOREIGN KEY(Actor_ID) REFERENCES Actor(_ID);
ALTER TABLE Actors_per_Movie ADD FOREIGN KEY(Movie_ID) REFERENCES Movie(_ID);	

ALTER TABLE Genders_per_Movie ADD FOREIGN KEY(Gender_ID) REFERENCES	Gender(_ID);
ALTER TABLE Genders_per_Movie ADD FOREIGN KEY(Movie_ID) REFERENCES Movie(_ID);	

ALTER TABLE Auditoriums_per_cinema ADD FOREIGN KEY(Cinema_ID) REFERENCES Cinema(_ID);
ALTER TABLE Auditoriums_per_cinema ADD FOREIGN KEY(Auditorium_ID)REFERENCES Auditorium(_ID);	

ALTER TABLE Seats_per_Auditorium ADD FOREIGN KEY(Auditorium_ID) REFERENCES Auditorium(_ID);
ALTER TABLE Seats_per_Auditorium ADD FOREIGN KEY (Seat_ID) REFERENCES Seat(_ID);

ALTER TABLE Screening ADD FOREIGN KEY(Cinema_ID) REFERENCES	Cinema(_ID);
ALTER TABLE Screening ADD FOREIGN KEY(Auditorium_ID) REFERENCES	Auditorium(_ID);
ALTER TABLE Screening ADD FOREIGN KEY(Movie_ID) REFERENCES Movie(_ID);

ALTER TABLE Reservation ADD FOREIGN KEY(Screening_ID) REFERENCES Screening(_ID);

ALTER TABLE Seats_Reserved ADD FOREIGN KEY(Reservation_ID) REFERENCES Reservation(_ID);
ALTER TABLE Seats_Reserved ADD FOREIGN KEY(Seat_ID) REFERENCES Seat(_ID);




