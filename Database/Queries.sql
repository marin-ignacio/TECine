---Selects Screening table
SELECT * 
FROM Screening;

---Selects every Movie's table
SELECT *
FROM Movie;

---Selects Actor's table
SELECT *
FROM Actor;

---Selects every actors per movie
SELECT *
FROM Actors_per_Movie;

---Selects Auditorium's table
SELECT *
FROM Auditorium;

---Selects Cinema's table
SELECT *
FROM Cinema;

---Selects Auditorium's per cinema
SELECT *
FROM Auditoriums_per_Cinema;

---Selects every Director
SELECT *
FROM Director;

---Selects every director per movie
SELECT *
FROM Directors_per_Movie;

---Selects every gender
SELECT *
FROM Gender;

---Selects every gender per movie
SELECT *
FROM Genders_per_Movie;

---Selects Reservation's table
SELECT *
FROM Reservation;

---Selects Seat table
SELECT *
FROM Seat;

---Select Seats per auditorium
SELECT *
FROM Seats_per_Auditorium;

---Selects the seats that are reserved
SELECT *
FROM Seats_Reserved;


-----******************************************************************************-----


/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Director
*/

CREATE FUNCTION _insert_director(_pName VARCHAR(40), _pLName VARCHAR(200)) RETURNS INT AS $$

BEGIN
    		IF ( (EXISTS(       ---If the name exists, does not insert
			SELECT Director._FName
			FROM Director
			WHERE _pName = Director._FName
			)) AND 
			(EXISTS(
			SELECT Director._LName
			FROM Director
			WHERE _pLName = Director._LName
			)) )THEN

        RETURN -1;
																	 
	ELSE
																	 
	DECLARE
    	_countDirID INT := COUNT(*) FROM Director; --- Increases Director's ID
		_tempID INT :=((_countDirID) + 1);
		
	BEGIN
		INSERT INTO Director(_ID, _FName, _LName)  --- Inserts directors name if it's different from the existing directors
		VALUES(_tempID, _pName, _pLName);
		RETURN _tempID;
		END;
		END IF;
		
END $$

LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Cinema
*/

CREATE FUNCTION _insert_cinema(_pName VARCHAR(40), _pLocation VARCHAR(200)) RETURNS INT AS $$

BEGIN
    		IF EXISTS(         --- If the name exists, does not insert
			SELECT Cinema._Name
			FROM Cinema
			WHERE _pName = Cinema._Name
			) THEN

        RAISE NOTICE 'That name already exists';
																	 
	ELSE
																	 
	DECLARE
    	_countCinemaID INT := COUNT(*) FROM Cinema; ---Increases Cinema's ID
		_tempID INT :=((_countCinemaID) + 1);
		
	BEGIN
		RETURN _tempID;
		INSERT INTO Cinema(_ID, _Name, _Location) ---Inserts into table the Cinema
		VALUES(_tempID, _pName, _pLocation);
		END;
		END IF;
END $$

LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Gender
*/
CREATE FUNCTION _insert_gender(_pName VARCHAR(40)) RETURNS INT AS $$

BEGIN
    		IF EXISTS(				---If name exists, doesn't inserts
			SELECT Gender._Name
			FROM Gender
			WHERE _pName = Gender._Name
			) THEN

        RAISE NOTICE 'That name already exists';
																	 
	ELSE
																	 
	DECLARE
    	_countGenderID INT := COUNT(*) FROM Gender;		---Increases gender's ID
		_tempID INT :=((_countGenderID) + 1);
		
	BEGIN	
		INSERT INTO Gender(_ID, _Name)	---Inserts gender into table
		VALUES(_tempID, _pName);
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
CREATE FUNCTION _insert_auditorium(_pName VARCHAR(40)) RETURNS INT AS $$

BEGIN
    		IF EXISTS(				--- If Auditorium's name exists, doesn't inserts
			SELECT Auditorium._Name
			FROM Auditorium
			WHERE _pName = Auditorium._Name
			) THEN

        RAISE NOTICE 'That name already exists';
																	 
	ELSE
																	 
	DECLARE
    	_countAuditoriumID INT := COUNT(*) FROM Auditorium;		---Increases Auditorium's ID
		_tempID INT :=((_countAuditoriumID) + 1);
		
	BEGIN	
		INSERT INTO Auditorium(_ID, _Name)			---Inserts into table the Auditorium's parameters
		VALUES(_tempID, _pName);
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
CREATE FUNCTION _insert_actor(_pName VARCHAR(40), _pLName VARCHAR(200)) RETURNS INT AS $$

BEGIN
    		IF ( (EXISTS(			---If Actor's name and last name exists, doesn't inserts
			SELECT Actor._FName
			FROM Actor
			WHERE _pName = Actor._FName
			)) AND 
			(EXISTS(
			SELECT Actor._LName
			FROM Actor
			WHERE _pLName = Actor._LName
			)) )THEN

        RETURN -1;
																	 
	ELSE
																	 
	DECLARE
    	_countActorID INT := COUNT(*) FROM Actor; 		---Increases Actor's ID
		_tempID INT :=((_countActorID) + 1);
		
	BEGIN
		INSERT INTO Actor(_ID, _FName, _LName)			---Inserts into table
		VALUES(_tempID, _pName, _pLName);
		RETURN _tempID;
		END;
		END IF;
		
END $$

LANGUAGE plpgsql;
				  
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
 --DESCRIPTION: Insertion in the table Cinema
*/

CREATE OR REPLACE FUNCTION _insert_screening(_pCinemaID INT, _pAuditoriumID INT, _pMovieID INT,_pDate DATE, _pHour TIME) RETURNS INT AS $$

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
CREATE FUNCTION _insert_reservation(_pScreening INT, _pActive BOOL) RETURNS INT AS $$

BEGIN
		IF EXISTS(			---If movie's title exists, doesn't insert
			SELECT Screening._ID
			FROM Screening
			WHERE _pScreening = Screening._ID
			) THEN

        RETURN -1;

	ELSE
				
	DECLARE
    	_countReservationID INT := COUNT(*) FROM Reservation; 		---Increases Reservation's ID
		_tempID INT :=((_countReservationID) + 1);
		
	BEGIN
		INSERT INTO Reservation(_ID, _Screening_ID, _Active)			---Inserts into table
		VALUES(_tempID, _pScreening, _pActive);
		RETURN _tempID;
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
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inserts genders per movie
*/

CREATE OR REPLACE FUNCTION _insert_genders_per_movie(_pGenderID INT, _pMovieID INT) RETURNS INT AS $$

BEGIN
    		IF (EXISTS(       ---If the ID exist, do not insert
			SELECT Genders_per_Movie._Movie_ID,Genders_per_Movie._Gender_ID
			FROM Genders_per_Movie
			WHERE _pMovieID = _Movie_ID AND _pGenderID = _Gender_ID
			) )THEN

        RETURN -1;
																	 
	ELSE
		
	BEGIN
		INSERT INTO Genders_per_Movie(_Gender_ID, _Movie_ID)  --- Inserts gender with movie if it's different from the existing directors
		VALUES( _pGenderID, _pMovieID);
		RETURN _pGenderID;
		END;
		END IF;
		
END $$
LANGUAGE plpgsql;
				  
/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: insert actors per movie
*/

CREATE OR REPLACE FUNCTION _insert_actors_per_movie(_pActorID INT, _pMovieID INT) RETURNS INT AS $$

BEGIN
    		IF (EXISTS(       ---If the ID exist, do not insert
			SELECT Actors_per_Movie._Movie_ID,Actors_per_Movie._Actor_ID
			FROM Actors_per_Movie
			WHERE _pMovieID = _Movie_ID AND _pActorID = _Actor_ID
			) )THEN

        RETURN -1;
																	 
	ELSE
		
	BEGIN
		INSERT INTO Actors_per_Movie(_Actor_ID, _Movie_ID)  --- Inserts actor with movie if it's different from the existing directors
		VALUES( _pActorID, _pMovieID);
		RETURN _pActorID;
		END;
		END IF;
		
END $$
LANGUAGE plpgsql;


/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: inserts director per movie
*/

CREATE OR REPLACE FUNCTION _insert_directors_per_movie(_pDirectorID INT, _pMovieID INT) RETURNS INT AS $$

BEGIN
    		IF (EXISTS(       ---If the ID exist, do not insert
			SELECT Directors_per_Movie._Movie_ID,Directors_per_Movie._Director_ID
			FROM Directors_per_Movie
			WHERE _pMovieID = _Movie_ID AND _pDirectorID = _Director_ID
			) )THEN

        RETURN -1;
																	 
	ELSE
		
	BEGIN
		INSERT INTO Directors_per_Movie(_Director_ID, _Movie_ID)  --- Inserts director with movie if it's different from the existing directors
		VALUES( _pDirectorID, _pMovieID);
		RETURN _pDirectorID;
		END;
		END IF;
		
END $$
LANGUAGE plpgsql;


-----******************************************************************************-----
																			 
/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Movies per Date per Cinema
*/
CREATE OR REPLACE FUNCTION _movies_dates_times(_pCinema_ID INT, _pDate DATE) 
RETURNS TABLE (_pID INT, _pTitle VARCHAR(40), _pTranslation VARCHAR(40), _pDuration_min INTERVAL, _pDescription VARCHAR(1000), _pImage BYTEA)
AS $$
																			 
DECLARE
		_my_table_ RECORD;
BEGIN
		FOR _my_table_ IN
		SELECT Movie._ID,Movie._Title,Movie._Translation,Movie._Duration_min, Movie._Description, Movie._Image
		FROM Screening
				INNER JOIN Movie ON Screening._Movie_ID= Movie._ID
		WHERE Screening._Cinema_ID = _pCinema_ID AND Screening._Date = _pDate
LOOP
					_pID:= _my_table_._ID;
					_pTitle:= _my_table_._Title;
					_pTranslation:= _my_table_._Translation;
					_pDuration_min:= _my_table_._Duration_min;
					_pDescription:= _my_table_._Description;
					_pImage:= _my_table_._Image;
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
CREATE OR REPLACE FUNCTION _movies_per_date(_pCinema_ID INT, _pMovie_ID INT, _pDate DATE) 
RETURNS TABLE (_pID INT, _pTitle VARCHAR(40), _pTranslation VARCHAR(40), _pDuration_min INTERVAL, _pDescription VARCHAR(1000), _pImage BYTEA, _pHour TIME)
AS $$
																			 
DECLARE
		_my_table_ RECORD;
BEGIN
		FOR _my_table_ IN
		SELECT Movie._ID,Movie._Title,Movie._Translation,Movie._Duration_min, Movie._Description, Movie._Image, Screening._Start_time
		FROM Screening
				INNER JOIN Movie ON Screening._Movie_ID= Movie._ID
		WHERE Screening._Cinema_ID = _pCinema_ID AND Screening._Date = _pDate AND Screening._Movie_ID = _pMovie_ID
LOOP
					_pID:= _my_table_._ID;
					_pTitle:= _my_table_._Title;
					_pTranslation:= _my_table_._Translation;
					_pDuration_min:= _my_table_._Duration_min;
					_pDescription:= _my_table_._Description;
					_pImage:= _my_table_._Image;
					_pHour:= _my_table_._Start_time;
RETURN NEXT;
END LOOP;
RETURN;
END $$
LANGUAGE plpgsql;
																			 
-----******************************************************************************-----																			
				
/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Movie, directors
*/
CREATE FUNCTION _movies_directors(_pMovie_ID INT) 
RETURNS TABLE (Director_Name VARCHAR(40),Director_Last_Name VARCHAR(200))
AS $$
																			 
DECLARE
		_directors_movies_ RECORD;
BEGIN
		FOR _directors_movies_ IN
		SELECT Director._FName, Director._LName
		FROM Directors_per_Movie
				INNER JOIN Director ON Directors_per_movie._Director_ID = Director._ID
			WHERE Directors_per_Movie._Movie_ID = _pMovie_ID
LOOP
				Director_Name := _directors_movies_._FName;
				Director_Last_Name := _directors_movies_._LName;
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
CREATE FUNCTION _movies_actors(_pMovie_ID INT) 
RETURNS TABLE (Actor_Name VARCHAR(40),Actor_Last_Name VARCHAR(200))
AS $$
																			 
DECLARE
		_actors_movies_ RECORD;
BEGIN
		FOR _actors_movies_ IN
		SELECT Actor._FName, Actor._LName
		FROM Actors_per_Movie
				INNER JOIN Actor ON Actors_per_movie._Actor_ID = Actor._ID
			WHERE Actors_per_Movie._Movie_ID = _pMovie_ID
LOOP
			Actor_Name := _actors_movies_._FName;
			Actor_Last_Name := _actors_movies_._LName;
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
CREATE FUNCTION _movies_genders(_pMovie_ID INT) 
RETURNS TABLE (Actor_Name VARCHAR(40))
AS $$
																			 
DECLARE
		_genders_movies_ RECORD;
BEGIN
		FOR _genders_movies_ IN
		SELECT Gender._Name
		FROM Genders_per_Movie
				INNER JOIN Gender ON Genders_per_movie._Gender_ID = Gender._ID
			WHERE Genders_per_Movie._Movie_ID = _pMovie_ID
LOOP
				Actor_Name := _genders_movies_._Name;
RETURN NEXT;
END LOOP;
RETURN;
END $$
LANGUAGE plpgsql;
																			 
															
																			 
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Movie, reservations

CREATE FUNCTION _movies_reservations(_pMovie_ID INT, _pCinemaID INT, _pDate DATE, _pHour TIME) 
RETURNS TABLE (Seat_Row CHAR, Seat_Number INT)
AS $$
																			 
DECLARE
		_reservations_movies_ RECORD;
BEGIN
		FOR _reservations_movies_ IN
		SELECT Seat._Row, Seat._Number
		FROM Seats_Reserved
			    INNER JOIN Seat ON Seats_Reserved._Seat_ID= Seat._ID
				INNER JOIN Reservation ON Seats_Reserved._Reservation_ID = Reservation._ID
				INNER JOIN Screening ON Reservation._Screening_ID = Screening._ID
		WHERE _Active = TRUE AND _Movie_ID = _pMovie_ID AND _Cinema_ID = _pCinemaID AND _Date = _pDate AND _Start_time = _pHour
LOOP
				Seat_Row := _reservations_movies_._Row;
				Seat_Number	:= _reservations_movies_._Number;			  
RETURN NEXT;
END LOOP;
RETURN;
END $$
LANGUAGE plpgsql;

 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Seats with name and row per 
								  
CREATE FUNCTION _auditorium_seats(_pCinema_ID INT, _pAuditorium_ID INT) 
RETURNS TABLE (_pSeat_ID INT,_pRow CHAR, _pNumber INT)
AS $$
																			 
DECLARE
		_seats_ RECORD;
BEGIN
		FOR _seats_ IN
		SELECT Seat._ID, Seat._Row, Seat._Number
		FROM Seats_per_Auditorium
				INNER JOIN Seat ON Seats_per_Auditorium._Seat_ID = Seat._ID
				INNER JOIN Auditoriums_per_Cinema ON Seats_per_Auditorium._Auditorium_ID = Auditoriums_per_Cinema._Auditorium_ID
			WHERE Auditoriums_per_Cinema._Cinema_ID = _pCinema_ID AND Auditoriums_per_Cinema._Auditorium_ID = _pAuditorium_ID
LOOP
				_pSeat_ID := _seats_._ID;
				_pRow := _seats_._Row;
				_pNumber := _seats_._Number;
RETURN NEXT;
END LOOP;
RETURN;
END $$
LANGUAGE plpgsql;
-----******************************************************************************-----
								  
DROP FUNCTION _movies_dates_times;
DROP FUNCTION _movies_directors;
DROP FUNCTION _movies_actors;
DROP FUNCTION _movies_genders;
DROP FUNCTION _movies_reservations;
DROP FUNCTION _insert_director;
DROP FUNCTION _insert_actor;
																			 
SELECT * FROM _movies_directors(3);
SELECT * FROM _movies_actors(3);
SELECT * FROM _movies_genders(3);
SELECT * FROM _movies_reservations(2,1,'01/12/2018','13:00');														
SELECT * FROM _movies_dates_times(1,'01/12/2018');
SELECT * FROM _movies_per_date(1,3,'01/12/2018');
SELECT * FROM generate_seats(6);
						
SELECT _insert_cinema('Hola','Alajuela');
SELECT _insert_gender('Misterio');
SELECT _insert_auditorium('Sala 10');
SELECT _insert_reservation(16,true);
SELECT _insert_screening(5,2,4,'30/11/2018','20:50');
SELECT _auditorium_seats(1,2);
								  
INSERT INTO Auditorium
	(_ID, _Name)
VALUES
	(6,'Sala 6');
								  
INSERT INTO Auditoriums_per_Cinema
	(_Cinema_ID, _Auditorium_ID)
VALUES
	(1,6);
								  
SELECT _insert_genders_per_movie(1,4);


