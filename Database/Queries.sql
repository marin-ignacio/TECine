														 
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

CREATE FUNCTION _insert_director3(_pName VARCHAR(40), _pLName VARCHAR(200)) RETURNS void AS $$

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
CREATE FUNCTION _insert_cinema(_pName VARCHAR(40), _pLocation VARCHAR(200)) RETURNS void AS $$

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
CREATE FUNCTION _insert_gender(_pName VARCHAR(40)) RETURNS void AS $$

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
		END;
		END IF;
END $$

LANGUAGE plpgsql;

/*
 --@AUTHOR Yenira Chacón
 --@CREATE DATE 15/11/2018
 --DESCRIPTION: Insertion in the table Auditorium
*/
CREATE FUNCTION _insert_auditorium(_pName VARCHAR(40)) RETURNS void AS $$

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
		END;
		END IF;
END $$

LANGUAGE plpgsql;

CREATE FUNCTION _insert_actor(_pName VARCHAR(40), _pLName VARCHAR(200)) RETURNS void AS $$

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

CREATE FUNCTION _insert_movie(_pTitle VARCHAR(40), _pDuration VARCHAR(200),_pDescription VARCHAR(1000),_pImage varchar(100)) 
RETURNS void AS $$

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
		INSERT INTO Movie(_ID, _Title,_Duration_min, _Description, _Image)
		VALUES(_tempID, _pTitle, _pDuration, _pDescription, read_binary_file(_pImage));
		END;
		END IF;
END $$

LANGUAGE plpgsql;

