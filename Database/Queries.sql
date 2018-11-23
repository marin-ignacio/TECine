SELECT * 
FROM Screening;

SELECT *
FROM Movie;

SELECT *
FROM Actor;

SELECT *
FROM Actors_per_Movie;

SELECT *
FROM Auditorium;

SELECT *
FROM Cinema;

SELECT *
FROM Auditoriums_per_Cinema;

SELECT *
FROM Director;

SELECT *
FROM Directors_per_Movie;

SELECT *
FROM Gender;

SELECT *
FROM Genders_per_Movie;

SELECT *
FROM Reservation;

SELECT *
FROM Seat;

SELECT *
FROM Seats_per_Auditorium;

SELECT *
FROM Seats_Reserved;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Director
*/

CREATE FUNCTION _insert_director(_pName VARCHAR(40), _pLName VARCHAR(200)) RETURNS INT AS $$

BEGIN
    		IF EXISTS(
			SELECT Director._FName
			FROM Director
			WHERE _pName = Director._FName
			) THEN

        RAISE NOTICE 'That name already exists';
    END IF;
																	 
   		IF EXISTS(
			SELECT Director._LName
			FROM Director
		WHERE _pName = Director._LName
			) THEN
       RAISE NOTICE 'That name already exists';
	ELSE
																	 
	DECLARE
    	_countDirID INT := COUNT(*) FROM Director;
		_tempID INT :=((_countDirID) + 1);
		
	BEGIN
		RETURN _tempID;
		INSERT INTO Director(_ID, _FName, _LName)
		VALUES(_tempID, _pName, _pLName);
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
		RETURN _tempID;
		INSERT INTO Gender(_ID, _Name)
		VALUES(_tempID, _pName);
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
		RETURN _tempID;
		INSERT INTO Auditorium(_ID, _Name)
		VALUES(_tempID, _pName);
		END;
		END IF;
END $$

LANGUAGE plpgsql;

CREATE FUNCTION _insert_actor(_pName VARCHAR(40), _pLName VARCHAR(200)) RETURN INT AS $$

BEGIN
    		IF EXISTS(
			SELECT Actor._FName
			FROM Actor
			WHERE _pName = Actor._FName
			) THEN

        RAISE NOTICE 'That name already exists';
    END IF;
																	 
   		IF EXISTS(
			SELECT Actor._LName
			FROM Actor
		WHERE _pName = Actor._LName
			) THEN
       RAISE NOTICE 'That name already exists';
	ELSE
																	 
	DECLARE
    	_countActorID INT := COUNT(*) FROM Actor;
		_tempID INT :=((_counActorID) + 1);
		
	BEGIN	
		RETURN _tempID;
		INSERT INTO Actor(_ID, _FName, _LName)
		VALUES(_tempID, _pName, _pLName);
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
RETURNS SETOF RECORD AS $$
																			 
DECLARE
		_my_table_ RECORD;
BEGIN
		FOR _my_table_ IN
		SELECT Movie._ID, Movie._Title, Movie._Translation, Screening._Date, Screening._Start_time
		FROM Screening
				INNER JOIN Movie ON Screening._Movie_ID= Movie._ID
		WHERE Screening._Cinema_ID = _pCinema_ID
LOOP
RETURN NEXT _my_table_;
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
RETURNS SETOF RECORD AS $$
																			 
DECLARE
		_directors_movies_ RECORD;
BEGIN
		FOR _directors_movies_ IN
		SELECT Movie._ID, Movie._Title, Movie._Translation, Director._FName, Director._LName
		FROM Directors_per_Movie
				INNER JOIN Movie ON Directors_per_Movie._Movie_ID= Movie._ID
				INNER JOIN Director ON Directors_per_movie._Director_ID = Director._ID
			WHERE Directors_per_Movie._Movie_ID = _pMovie_ID
LOOP
RETURN NEXT _directors_movies_;
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
RETURNS SETOF RECORD AS $$
																			 
DECLARE
		_actors_movies_ RECORD;
BEGIN
		FOR _actors_movies_ IN
		SELECT Movie._ID, Movie._Title, Movie._Translation, Actor._FName, Actor._LName
		FROM Actors_per_Movie
				INNER JOIN Movie ON Actors_per_Movie._Movie_ID= Movie._ID
				INNER JOIN Actor ON Actors_per_movie._Actor_ID = Actor._ID
			WHERE Actors_per_Movie._Movie_ID = _pMovie_ID
LOOP
RETURN NEXT _actors_movies_;
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
RETURNS SETOF RECORD AS $$
																			 
DECLARE
		_genders_movies_ RECORD;
BEGIN
		FOR _genders_movies_ IN
		SELECT Movie._ID, Movie._Title, Movie._Translation, Gender._Name
		FROM Genders_per_Movie
				INNER JOIN Movie ON Genders_per_Movie._Movie_ID= Movie._ID
				INNER JOIN Gender ON Genders_per_movie._Gender_ID = Gender._ID
			WHERE Genders_per_Movie._Movie_ID = _pMovie_ID
LOOP
RETURN NEXT _genders_movies_;
END LOOP;
RETURN;
END $$

LANGUAGE plpgsql;

--PRUEBITAS---
DROP FUNCTION _movies_dates_times;
DROP FUNCTION _movies_directors;
DROP FUNCTION _movies_actors;
DROP FUNCTION _movies_genders;
																			 
SELECT * FROM _movies_dates_times(1) AS (Movie INT, movie_title VARCHAR(40), movie_translation VARCHAR(40),_screening_date DATE,_screening_hour TIME);
SELECT * FROM _movies_directors(3) AS (Movie INT, movie_title VARCHAR(40), movie_translation VARCHAR(40),Director_Name VARCHAR(40),Director_Last_Name VARCHAR(200));
SELECT * FROM _movies_actors(3) AS (Movie INT, movie_title VARCHAR(40), movie_translation VARCHAR(40),Actor_Name VARCHAR(40),Actor_Last_Name VARCHAR(200));
SELECT * FROM _movies_genders(3) AS (Movie INT, movie_title VARCHAR(40), movie_translation VARCHAR(40),Actor_Name VARCHAR(40));

SELECT _insert_director3('Juanito','Mora');
SELECT _insert_cinema('Hola','Alajuela');
SELECT _insert_gender('Misterio');
SELECT _insert_auditorium('Sala 10');
