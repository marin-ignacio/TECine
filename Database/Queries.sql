/*---------------------------------------------------------------------------------------------------------------------
-------------------------------------------- INSERTS FUNCTIONS --------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------*/

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Movie
*/

CREATE FUNCTION _insert_movie(_pTitle VARCHAR(40),_pTranslation VARCHAR(40), _pDuration VARCHAR(200),_pDescription VARCHAR(1000),_pImage varchar(10485760)) 
RETURNS INT AS $$

BEGIN
    		IF EXISTS(			---If movie's title exists, doesn't insert
			SELECT Movie._Title
			FROM Movie
			WHERE _pTitle = Movie._Title
			) THEN

        RETURN -1;

	ELSE
																	 
	DECLARE
    	_countMovieID INT := COUNT(*) FROM Movie;	---Increases movie's ID
		_tempID INT :=((_countMovieID) + 1);
		
	BEGIN
		INSERT INTO Movie(_ID, _Title, _Translation, _Duration_min, _Description, _Image)	---Inserts into movie
		VALUES(_tempID, _pTitle, _pTranslation, _pDuration, _pDescription, _pImage);
		RETURN _tempID;
		END;
		END IF;
END $$
LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Director
*/
CREATE OR REPLACE FUNCTION insert_director(pFname VARCHAR(40), pLname VARCHAR(40)) RETURNS INT AS $$
BEGIN
	IF ((EXISTS(SELECT	Director._Fname
				FROM	Director
				WHERE	pFname = Director._Fname)) 
		AND 
		(EXISTS(SELECT	Director._Lname
				FROM	Director
				WHERE	pLname = Director._Lname)))
		THEN
        	RETURN -1;															 
	ELSE						 
		DECLARE
    		_countDirID INT := COUNT(*) FROM Director;
			_tempID INT :=((_countDirID) + 1);
		BEGIN
			INSERT INTO Director
				(_ID, _Fname, _Lname)
			VALUES
				(_tempID, pFname, pLname);
			RETURN _tempID;
		END;
	END IF;
END $$
LANGUAGE plpgsql;
				  
/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Actor
*/
CREATE OR REPLACE FUNCTION insert_actor(pFname VARCHAR(40), pLname VARCHAR(40)) RETURNS INT AS $$
BEGIN
	IF ((EXISTS(SELECT	Actor._FName
				FROM	Actor
				WHERE	pFname = Actor._FName)) 
		AND 
		(EXISTS(SELECT	Actor._LName
				FROM	Actor
				WHERE	pLname = Actor._LName)))
		THEN
        	RETURN -1;															 
	ELSE						 
		DECLARE
    		_countActorID INT := COUNT(*) FROM Actor;
			_tempID INT :=((_countActorID) + 1);
		BEGIN
			INSERT INTO Actor
				(_ID, _Fname, _Lname)
			VALUES
				(_tempID, pFname, pLname);
			RETURN _tempID;
		END;
	END IF;
END $$
LANGUAGE plpgsql;
				  
/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Gender
*/
CREATE OR REPLACE FUNCTION insert_gender(pName VARCHAR(40)) RETURNS INT AS $$
BEGIN
	IF EXISTS(SELECT	Gender._Name
			   FROM		Gender
			   WHERE	pName = Gender._Name) 
		THEN
        	RETURN -1;															 
	ELSE						 
		DECLARE
    		_countGenderID INT := COUNT(*) FROM Gender;
			_tempID INT :=((_countGenderID) + 1);
		BEGIN	
			INSERT INTO Gender
				(_ID, _Name)
			VALUES
				(_tempID, pName);
			RETURN _tempID;
		END;
	END IF;
END $$
LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: inserts director per movie
*/
CREATE OR REPLACE FUNCTION insert_directors_per_movie(pDirectorID INT, pMovieID INT) RETURNS INT AS $$
BEGIN
	IF (EXISTS(SELECT	Directors_per_Movie._Movie_ID, Directors_per_Movie._Director_ID
			    FROM 	Directors_per_Movie
				WHERE 	pMovieID = _Movie_ID AND pDirectorID = _Director_ID))
		THEN
        	RETURN -1;																 
	ELSE	
		BEGIN
			INSERT INTO Directors_per_Movie
			   (_Director_ID, _Movie_ID)
			VALUES
			   (pDirectorID, pMovieID);
			RETURN 0;
		END;
	END IF;
END $$
LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: insert actors per movie
*/
CREATE OR REPLACE FUNCTION insert_actors_per_movie(pActorID INT, pMovieID INT) RETURNS INT AS $$
BEGIN
	IF (EXISTS(SELECT	Actors_per_Movie._Movie_ID, Actors_per_Movie._Actor_ID
				FROM	Actors_per_Movie
				WHERE	pMovieID = _Movie_ID AND pActorID = _Actor_ID))
		THEN
        	RETURN -1;														 
	ELSE
		BEGIN
			INSERT INTO Actors_per_Movie
			   (_Actor_ID, _Movie_ID)
			VALUES
			   (pActorID, pMovieID);
			RETURN 0;
		END;
	END IF;	
END $$
LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inserts genders per movie
*/
CREATE OR REPLACE FUNCTION insert_genders_per_movie(pGenderID INT, pMovieID INT) RETURNS INT AS $$
BEGIN
	IF (EXISTS(SELECT	Genders_per_Movie._Movie_ID, Genders_per_Movie._Gender_ID
				FROM	Genders_per_Movie
				WHERE 	pMovieID = _Movie_ID AND pGenderID = _Gender_ID))
		THEN
        	RETURN -1;												 
	ELSE
		BEGIN
			INSERT INTO Genders_per_Movie
				   (_Gender_ID, _Movie_ID) 
			VALUES
				   (pGenderID, pMovieID);
			RETURN 0;
		END;
	END IF;
END $$
LANGUAGE plpgsql;
				
/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Cinema
*/
CREATE OR REPLACE FUNCTION insert_cinema(pName VARCHAR(40), pLocation VARCHAR(40)) RETURNS INT AS $$
BEGIN
	IF EXISTS(SELECT	Cinema._Name
			   FROM		Cinema
			   WHERE 	pName = Cinema._Name) 
		THEN
        	RETURN -1;															 
	ELSE						 
		DECLARE
    		_countCinemaID INT := COUNT(*) FROM Cinema;
			_tempID INT :=((_countCinemaID) + 1);
		BEGIN
			INSERT INTO Cinema
				(_ID, _Name, _Location)
			VALUES
				(_tempID, pName, pLocation);
			RETURN _tempID;
		END;
	END IF;
END $$
LANGUAGE plpgsql;
				
/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Auditorium
*/
CREATE OR REPLACE FUNCTION insert_auditorium(pName VARCHAR(40)) RETURNS INT AS $$
BEGIN
	IF EXISTS(SELECT	Auditorium._Name
			   FROM		Auditorium
			   WHERE	pName = Auditorium._Name) 
		THEN
        	RETURN -1;															 
	ELSE					 
		DECLARE
    		_countAuditoriumID INT := COUNT(*) FROM Auditorium;
			_tempID INT :=((_countAuditoriumID) + 1);
		BEGIN	
			INSERT INTO Auditorium
				(_ID, _Name)
			VALUES
				(_tempID, pName);
			RETURN _tempID;
		END;
	END IF;
END $$
LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inserts auditoriums per cinema
*/
CREATE OR REPLACE FUNCTION insert_auditoriums_per_cinema(pCinemaID INT, pAuditoriumID INT) RETURNS INT AS $$
BEGIN
	IF (EXISTS(SELECT	Auditoriums_per_Cinema._Cinema_ID, Auditoriums_per_Cinema._Auditorium_ID
				FROM	Auditoriums_per_Cinema
				WHERE 	pCinemaID = _Cinema_ID AND pAuditoriumID = _Auditorium_ID))
		THEN
        	RETURN -1;												 
	ELSE
		BEGIN
			INSERT INTO Auditoriums_per_Cinema
				   (_Cinema_ID, _Auditorium_ID) 
			VALUES
				   (pCinemaID, pAuditoriumID);
			RETURN 0;
		END;
	END IF;
END $$
LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Generate seats function
*/
																  
CREATE OR REPLACE FUNCTION generate_seats (_pAuditorium_ID INT) 
 RETURNS void AS $$ 
DECLARE
   _counter INTEGER := 0 ; 
BEGIN
 
 
 WHILE _counter <= 24 LOOP
 _counter := _counter + 1; 
 INSERT INTO Seats_per_Auditorium
	(_Auditorium_ID, _Seat_ID)
VALUES
	(_pAuditorium_ID, _counter);	
 END LOOP ; 
 RETURN;
END $$
LANGUAGE plpgsql;	

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Screening
*/
CREATE OR REPLACE FUNCTION insert_screening(_pCinemaID INT, _pAuditoriumID INT, _pMovieID INT,_pDate DATE, _pHour TIME) RETURNS INT AS $$

BEGIN
    		IF (EXISTS(       ---If the ID exist, do not insert
			SELECT Screening._Cinema_ID,Screening._Auditorium_ID, Screening._Movie_ID, Screening._Date, Screening._Start_time
			FROM Screening
			WHERE _pCinemaID = _Cinema_ID AND _pAuditoriumID = _Auditorium_ID AND _pMovieID = _Movie_ID AND _pDate = _Date AND _pHour = _Start_time
			) )THEN

        RETURN -1;
																	 
	ELSE
	
	DECLARE
		_countScreeningID INT := COUNT(*) FROM Screening; 		---Increases Screening's ID
		_tempID INT :=((_countScreeningID) + 1);
		
	BEGIN
		INSERT INTO Screening(_ID,_Cinema_ID,_Auditorium_ID,_Movie_ID,_Date,_Start_time) --- Inserts gender with movie if it's different from the existing directors
		VALUES(_tempID,_pCinemaID, _pAuditoriumID, _pMovieID, _pDate, _pHour);
		RETURN _pCinemaID;
		END;
		END IF;
		
END $$

LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the Reservation table
*/		
CREATE OR REPLACE FUNCTION insert_reservation(pScreeningID INT) RETURNS INT AS $$
BEGIN
	IF NOT EXISTS(SELECT	Screening._ID
			   		FROM	Screening
			 		WHERE 	pScreeningID = Screening._ID) 
		THEN
        	RETURN -1;
	ELSE
		DECLARE
    		_countReservationID INT := COUNT(*) FROM Reservation; 
			_tempID INT :=((_countReservationID) + 1);
		BEGIN
			INSERT INTO Reservation
				(_ID, _Screening_ID, _Active)
			VALUES
				(_tempID, pScreeningID, TRUE);
			RETURN _tempID;
		END;
	END IF;
END $$
LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: inserts seats reserved
*/
CREATE OR REPLACE FUNCTION insert_seats_reserved(pReservationID INT, pSeatID INT) RETURNS INT AS $$
BEGIN
	IF (EXISTS(SELECT	Seats_Reserved._Reservation_ID, Seats_Reserved._Seat_ID
			    FROM 	Seats_Reserved
				WHERE 	pReservationID = _Reservation_ID AND pSeatID = _Seat_ID))
		THEN
        	RETURN -1;																 
	ELSE	
		BEGIN
			INSERT INTO Seats_Reserved
			   (_Reservation_ID, _Seat_ID)
			VALUES
			   (pReservationID, pSeatID);
			RETURN 0;
		END;
	END IF;
END $$
LANGUAGE plpgsql;	
				
/*---------------------------------------------------------------------------------------------------------------------
--------------------------------------------- GETS FUNCTIONS ----------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------*/
				
/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Movie, directors
*/
CREATE OR REPLACE FUNCTION movie_directors(pMovie_ID INT) 
RETURNS TABLE (Director_ID INT, Director_Name VARCHAR(40),Director_Last_Name VARCHAR(40)) AS $$																	 
DECLARE
		directors_movie RECORD;
	BEGIN
		FOR directors_movie IN
			SELECT	Director._ID, Director._Fname, Director._Lname
			FROM 	Directors_per_Movie INNER JOIN Director ON Directors_per_movie._Director_ID = Director._ID
			WHERE 	Directors_per_Movie._Movie_ID = pMovie_ID
		LOOP
			Director_ID := directors_movie._ID;															 
			Director_Name := directors_movie._Fname;
			Director_Last_Name := directors_movie._Lname;
			RETURN NEXT;
		END LOOP;
		RETURN;
END $$
LANGUAGE plpgsql;
																					 
/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Movie, actors
*/																					 
CREATE OR REPLACE FUNCTION movie_actors(pMovie_ID INT) 
RETURNS TABLE (Actor_ID INT, Actor_Name VARCHAR(40),Actor_Last_Name VARCHAR(40)) AS $$																		 
DECLARE
		actors_movie RECORD;
BEGIN
		FOR actors_movie IN
			SELECT	Actor._ID, Actor._Fname, Actor._Lname
			FROM	Actors_per_Movie INNER JOIN Actor ON Actors_per_movie._Actor_ID = Actor._ID
			WHERE	Actors_per_Movie._Movie_ID = pMovie_ID
		LOOP
			Actor_ID := actors_movie._ID;
			Actor_Name := actors_movie._Fname;
			Actor_Last_Name := actors_movie._Lname;
			RETURN NEXT;
		END LOOP;
		RETURN;
END $$
LANGUAGE plpgsql;

/*																			
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Movie, genders
*/
CREATE OR REPLACE FUNCTION movie_genders(pMovie_ID INT) 
RETURNS TABLE (Gender_ID INT, Gender_Name VARCHAR(40)) AS $$																			 
DECLARE
		genders_movie RECORD;
BEGIN
		FOR genders_movie IN
			SELECT	Gender._ID, Gender._Name
			FROM	Genders_per_Movie INNER JOIN Gender ON Genders_per_movie._Gender_ID = Gender._ID
			WHERE	Genders_per_Movie._Movie_ID = pMovie_ID
		LOOP
			Gender_ID := genders_movie._ID;						  
			Gender_Name := genders_movie._Name;
			RETURN NEXT;
		END LOOP;
		RETURN;
END $$
LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Movies per Date per Cinema
*/
CREATE OR REPLACE FUNCTION date_movies(pCinema_ID INT, pDate VARCHAR(15)) 
RETURNS TABLE (_pID INT, _pTitle VARCHAR(40), _pTranslation VARCHAR(40), _pDuration_min INTERVAL, _pDescription VARCHAR(700), _pImage BYTEA)
AS $$																		 
DECLARE
		my_table RECORD;
BEGIN
	FOR my_table IN
		SELECT	Movie._ID, Movie._Title, Movie._Translation, Movie._Duration_min, Movie._Description, Movie._Image
		FROM	Screening INNER JOIN Movie ON Screening._Movie_ID= Movie._ID
		WHERE	Screening._Cinema_ID = pCinema_ID AND Screening._Date = pDate
	LOOP
		_pID:= my_table._ID;
		_pTitle:= my_table._Title;
		_pTranslation:= my_table._Translation;
		_pDuration_min:= my_table._Duration_min;
		_pDescription:= my_table._Description;
		_pImage:= my_table._Image;
		RETURN NEXT;
	END LOOP;
	RETURN;
END $$
LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Movies per Date per Cinema
*/
CREATE OR REPLACE FUNCTION movie_start_time(pCinema_ID INT, pMovie_ID INT, pDate VARCHAR(20)) 
RETURNS TABLE (_Start_time TIME) AS $$																 
DECLARE
		my_table RECORD;
BEGIN
		FOR my_table IN
			SELECT	Screening._Start_time
			FROM	Screening INNER JOIN Movie ON Screening._Movie_ID= Movie._ID
			WHERE	Screening._Cinema_ID = pCinema_ID AND Screening._Date = pDate AND Screening._Movie_ID = pMovie_ID
		LOOP
			_Start_time := my_table._Start_time;				
			RETURN NEXT;
		END LOOP;
		RETURN;
END $$
LANGUAGE plpgsql;

/*																			
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Cinema, Auditorium
*/
CREATE OR REPLACE FUNCTION cinema_auditoriums(pCinema_ID INT) 
RETURNS TABLE (Auditorium_ID INT, Auditorium_Name VARCHAR(40)) AS $$																			 
DECLARE
		auditoriums_cinema RECORD;
BEGIN
		FOR auditoriums_cinema IN
			SELECT	Auditorium._ID, Auditorium._Name
			FROM	Auditoriums_per_Cinema INNER JOIN Auditorium ON Auditoriums_per_Cinema._Auditorium_ID = Auditorium._ID
			WHERE	Auditoriums_per_Cinema._Cinema_ID = pCinema_ID
		LOOP
			Auditorium_ID := auditoriums_cinema._ID;						  
			Auditorium_Name := auditoriums_cinema._Name;
			RETURN NEXT;
		END LOOP;
		RETURN;
END $$
LANGUAGE plpgsql;

/*
--@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Seats with name and row per 
*/								  
CREATE OR REPLACE FUNCTION auditorium_seats(pAuditorium_ID INT) 
RETURNS TABLE (Seat_ID INT, Seat_Row CHAR, Seat_Number INT) AS $$																			 
DECLARE
		seats RECORD;
BEGIN
		FOR seats IN
			SELECT	Seat._ID, Seat._Row, Seat._Number
			FROM	Seats_per_Auditorium INNER JOIN Seat ON Seats_per_Auditorium._Seat_ID = Seat._ID
										 INNER JOIN Auditorium ON Seats_per_Auditorium._Auditorium_ID = Auditorium._ID
			WHERE	Seats_per_Auditorium._Auditorium_ID = pAuditorium_ID
		LOOP
			Seat_ID := seats._ID;
			Seat_Row := seats._Row;
			Seat_Number := seats._Number;
			RETURN NEXT;		
		END LOOP;
		RETURN;
END $$
LANGUAGE plpgsql;

 /*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Movie, genders
*/
CREATE OR REPLACE FUNCTION screening_seats_reserved(pScreening_ID INT) 
RETURNS TABLE (Seat_ID INT, Seat_Row CHAR, Seat_Number INT) AS $$
DECLARE
	seats_reserved_screening RECORD;
BEGIN
	FOR		seats_reserved_screening IN
		SELECT	Seat._ID, Seat._Row, Seat._Number
		FROM	Seats_Reserved INNER JOIN Seat ON Seats_Reserved._Seat_ID= Seat._ID
							   INNER JOIN Reservation ON Seats_Reserved._Reservation_ID = Reservation._ID
							   INNER JOIN Screening ON Reservation._Screening_ID = Screening._ID
		WHERE _Active = TRUE AND Screening._ID = pScreening_ID
	LOOP
		Seat_ID := seats_reserved_screening._ID;
		Seat_Row := seats_reserved_screening._Row;
		Seat_Number	:= seats_reserved_screening._Number;			  
		RETURN NEXT;
	END LOOP;
	RETURN;
END $$
LANGUAGE plpgsql;
