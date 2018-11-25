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

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Director
*/

CREATE FUNCTION _insert_director(_pFname VARCHAR(40), _pLname VARCHAR(200)) RETURNS INT AS $$

BEGIN
    		IF ( (EXISTS(
			SELECT Director._Fname
			FROM Director
			WHERE _pFname = Director._Fname
			)) AND 
			(EXISTS(
			SELECT Director._Lname
			FROM Director
			WHERE _pLname = Director._Lname
			)) )THEN

        RETURN -1;
																	 
	ELSE
																	 
	DECLARE
    	_countDirID INT := COUNT(*) FROM Director;
		_tempID INT :=((_countDirID) + 1);
		
	BEGIN
		INSERT INTO Director(_ID, _Fname, _Lname)
		VALUES(_tempID, _pFname, _pLname);
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
DROP FUNCTION _insert_cinema;
CREATE FUNCTION _insert_cinema(_pName VARCHAR(40), _pLocation VARCHAR(200)) RETURNS INT AS $$

BEGIN
    		IF EXISTS(
			SELECT Cinema._Name
			FROM Cinema
			WHERE _pName = Cinema._Name
			) THEN

        RAISE NOTICE 'That name already exists';
																	 
	ELSE
																	 
	DECLARE
    	_countCinemaID INT := COUNT(*) FROM Cinema;
		_tempID INT :=((_countCinemaID) + 1);
		
	BEGIN
		RETURN _tempID;
		INSERT INTO Cinema(_ID, _Name, _Location)
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
    		IF EXISTS(
			SELECT Gender._Name
			FROM Gender
			WHERE _pName = Gender._Name
			) THEN

        RAISE NOTICE 'That name already exists';
																	 
	ELSE
																	 
	DECLARE
    	_countGenderID INT := COUNT(*) FROM Gender;
		_tempID INT :=((_countGenderID) + 1);
		
	BEGIN	
		INSERT INTO Gender(_ID, _Name)
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
    		IF EXISTS(
			SELECT Auditorium._Name
			FROM Auditorium
			WHERE _pName = Auditorium._Name
			) THEN

        RAISE NOTICE 'That name already exists';
																	 
	ELSE
																	 
	DECLARE
    	_countAuditoriumID INT := COUNT(*) FROM Auditorium;
		_tempID INT :=((_countAuditoriumID) + 1);
		
	BEGIN	
		INSERT INTO Auditorium(_ID, _Name)
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
CREATE FUNCTION _insert_actor(_pFname VARCHAR(40), _pLname VARCHAR(200)) RETURNS INT AS $$

BEGIN
    		IF ( (EXISTS(
			SELECT Actor._Fname
			FROM Actor
			WHERE _pFname = Actor._Fname
			)) AND 
			(EXISTS(
			SELECT Actor._Lname
			FROM Actor
			WHERE _pLname = Actor._Lname
			)) )THEN

        RETURN -1;
																	 
	ELSE
																	 
	DECLARE
    	_countActorID INT := COUNT(*) FROM Actor;
		_tempID INT :=((_countActorID) + 1);
		
	BEGIN
		INSERT INTO Actor(_ID, _Fname, _Lname)
		VALUES(_tempID, _pFname, _pLname);
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
DROP FUNCTION _insert_movie;
CREATE FUNCTION _insert_movie(_pTitle VARCHAR(40), _pDuration VARCHAR(200),_pDescription VARCHAR(1000),_pImage varchar(100)) 
RETURNS INT AS $$

BEGIN
    		IF EXISTS(
			SELECT Movie._Title
			FROM Movie
			WHERE _pTitle = Movie._Title
			) THEN

        RAISE NOTICE 'That name already exists';

	ELSE
																	 
	DECLARE
    	_countMovieID INT := COUNT(*) FROM Movie;
		_tempID INT :=((_countMovieID) + 1);
		
	BEGIN
		RETURN _tempID;
		INSERT INTO Movie(_ID, _Title,_Duration_min, _Description, _Image)
		VALUES(_tempID, _pTitle, _pDuration, _pDescription, read_binary_file(_pImage));
		END;
		END IF;
END $$

LANGUAGE plpgsql;
																			 
																			 
/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 21/11/2018
 --DESCRIPTION: Inner Join Movie, Cinema, Movie transalation, Date, Hour
*/
CREATE FUNCTION _movies_dates_times(_pCinema_ID INT) 
RETURNS TABLE (_screening_date DATE,_screening_hour TIME)
AS $$
																			 
DECLARE
		_my_table_ RECORD;
BEGIN
		FOR _my_table_ IN
		SELECT Screening._Date, Screening._Start_time
		FROM Screening
				INNER JOIN Movie ON Screening._Movie_ID= Movie._ID
		WHERE Screening._Cinema_ID = _pCinema_ID
LOOP
					_screening_date:= _my_table_._Date;
					_screening_hour:= _my_table_._Start_time;
RETURN NEXT;
END LOOP;
RETURN;
END $$
LANGUAGE plpgsql;
																			
				
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
 --DESCRIPTION: Inner Join Movie, genders
*/
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

--SELECTS---
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
SELECT * FROM _movies_dates_times(1);

SELECT _insert_cinema('Hola','Alajuela');
SELECT _insert_gender('Misterio');
SELECT _insert_auditorium('Sala 10');

