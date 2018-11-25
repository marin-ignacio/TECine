INSERT INTO Administrator
	(_ID, _Username, _Password)
VALUES
	(1, 'nachomarin', '1234'),
	(2, 'reiracm', '1234'),
	(3, 'asolera', '1234'),
	(4, 'dayannaqs', '1234');
	
INSERT INTO Movie
	(_ID, _Title, _Translation, _Duration_min, _Description, _Image)
VALUES
	(1,'Spirited Away','El viaje de Chihiro','02:05:00','Perdida en el bosque, una niña de 10 años conoce animales, fantasmas y criaturas extrañas.', pg_read_binary_file('C:\SPIRITED_AWAY.jpg')),
	(2,'Big Heroes','Grandes Héroes','01:48:00','Cuando un giro inesperado de eventos los sumerge en el medio de un peligroso plan, un niño prodigio, su robot y sus amigos se convierten en héroes de alta tecnología en una misión para salvar su ciudad.',pg_read_binary_file('C:\BIG_HEROES.jpg')),
	(3,'The Jungle Book','El Libro de la Selva','01:47:00','Después de ser rescatado por la pantera Bagheera en la selva, una manada de lobos cría al recién nacido Mowgli. La vida feliz y apacible de Mowgli junto a su familia adoptiva se rompe en mil pedazos cuando llega el peligroso tigre Shere Khan.',pg_read_binary_file('C:\THE_JUNGLE_BOOK.jpeg')),
	(4,'The Guardians of the Galaxy: Vol 1','Guardianes de la Galaxia: Vol 1','02:02:00','Un aventurero espacial se convierte en la presa de unos cazadores de tesoros después de que él roba el orbe de un villano traicionero, y cuando descubre su poder, él debe encontrar la forma de unir a unos rivales para salvar al universo.',pg_read_binary_file('C:\GUARDIANS_OF_THE_GALAXY.jpg')),
	(5,'Christopher Robin','Christopher Robin','01:44:00','Christopher Robin ha crecido y, ahora que es adulto, ha olvidado a sus amigos de la infancia y ha perdido el rumbo. Winnie the Pooh y sus compañeros viajan a Londres para salvar a Christopher y ayudarle a reencontrar la alegría.',pg_read_binary_file('C:\CHRISTOPHER_ROBIN.jpg'));

INSERT INTO Director
	(_ID, _Fname, _Lname)
VALUES
	(1, 'Miyazaki','Hayao'),
	(2, 'Don','Hall'),
	(3,'Chris','Williams'),
	(4,'Jon','Favreau'),
	(5,'James','Gunn'),
	(6,'Marc','Forster');
	
INSERT INTO Actor
	(_ID,_Fname,_Lname)
VALUES
	(1,'Hiragi','Rumi'),
	(2,'Ryan','Potter'),
	(3,'Scott','Adsit'),
	(4,'Neel','Sethi'),
	(5,'Bill','Murray'),
	(6,'Ben','Kingsley'),
	(7,'Scarlett','Johansson'),
	(8,'Chris','Pratt'),
	(9,'Zoey','Saldana'),
	(10,'Bradley','Cooper'),
	(11,'Dave','Bautista'),
	(12,'Vin','Diesel'),
	(13,'Ewan','McGregor'),
	(14,'Hailey','Atwell');
	
INSERT INTO Gender
	(_ID, _Name)
VALUES
	(1,'Animación'),
	(2,'Aventura'),
	(3,'Fantasía'),
	(4,'Drama'),
	(5,'Acción'),
	(6,'Comedia'),
	(7,'Ciencia Ficción'),
	(8,'Superhéroes');

INSERT INTO Directors_per_Movie
	(_Director_ID,_Movie_ID)
VALUES
	(1,1),
	(2,2),
	(2,3),
	(3,4),
	(4,5),
	(6,5);

INSERT INTO Actors_per_Movie
	(_Actor_ID,_Movie_ID)
VALUES
	(1,1),
	(2,2),
	(3,2),
	(4,3),
	(5,3),
	(6,3),
	(7,3),
	(8,4),
	(9,4),
	(10,4),
	(11,4),
	(12,4),
	(13,5),
	(14,5);
	
INSERT INTO Genders_per_Movie
	(_Gender_ID,_Movie_ID)
VALUES
	(2,1),
	(3,1),
	(4,1),
	(1,2),
	(3,3),
	(2,3),
	(1,3),
	(8,4),
	(7,4),
	(5,4),
	(6,4),
	(3,5);
	
INSERT INTO Cinema
	(_ID,_Name,_Location)
VALUES
	(1,'Magaly','Calle 23, San José'),
	(2,'Sala Garbo','Calle 28, San José'),
	(3,'Nova Cinemas','Curridabat, San José'),
	(4,'Cinépolis, Paseo Metrópoli','La Lima, Cartago'),
	(5,'Cinemark, Multiplaza Curridabat','Curridabat, San José');
	
INSERT INTO Auditorium
	(_ID, _Name)
VALUES
	(1,'Sala 1'),
	(2,'Sala 2'),
	(3,'Sala 3'),
	(4,'Sala 4'),
	(5,'Sala 5');
	
INSERT INTO Auditoriums_per_Cinema
	(_Cinema_ID, _Auditorium_ID)
VALUES
	(1,1),(1,2),(1,3),
	(2,1),(2,2),
	(3,1),(3,2),
	(4,1),(4,2),(4,3),(4,4),(4,5),
	(5,1),(5,2),(5,3),(5,4);
	
INSERT INTO Seat
	(_ID,_Row,_Number)
VALUES
	(1,'A',1),
	(2,'A',2),
	(3,'A',3),	
	(4,'A',4),	
	(5,'A',5),	
	(6,'B',1),
	(7,'B',2),
	(8,'B',3),	
	(9,'B',4),	
	(10,'B',5),
	(11,'C',1),
	(12,'C',2),
	(13,'C',3),	
	(14,'C',4),	
	(15,'C',5),
	(16,'D',1),
	(17,'D',2),
	(18,'D',3),	
	(19,'D',4),	
	(20,'D',5),
	(21,'E',1),
	(22,'E',2),
	(23,'E',3),	
	(24,'E',4),	
	(25,'E',5);

INSERT INTO Seats_per_Auditorium
	(_Auditorium_ID, _Seat_ID)
VALUES
	(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),
	(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),	
	(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),
	(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),
	(2,11),(2,12),(2,13),(2,14),(2,15),(2,16),(2,17),(2,18),(2,19),	
	(2,20),(2,21),(2,22),(2,23),(2,24),(2,25),
	(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),
	(3,11),(3,12),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(3,19),	
	(3,20),(3,21),(3,22),(3,23),(3,24),(3,25),
	(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9),(4,10),
	(4,11),(4,12),(4,13),(4,14),(4,15),(4,16),(4,17),(4,18),(4,19),	
	(4,20),(4,21),(4,22),(4,23),(4,24),(4,25),
	(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,9),(5,10),
	(5,11),(5,12),(5,13),(5,14),(5,15),(5,16),(5,17),(5,18),(5,19),	
	(5,20),(5,21),(5,22),(5,23),(5,24),(5,25);
	
INSERT INTO Screening
	(_ID,_Cinema_ID,_Auditorium_ID,_Movie_ID,_Date,_Start_time)
VALUES
	(1,1,1,2,'01/12/2018','13:00'),
	(2,1,1,3,'01/12/2018','16:15'),
	(3,1,2,4,'01/12/2018','13:00'),
	(4,1,2,1,'02/12/2018','13:40'),
	(5,1,3,5,'02/12/2018','14:10'),
	(6,1,3,3,'02/12/2018','17:00'),
	(7,1,1,5,'30/11/2018','15:05'),
	(8,1,2,1,'30/11/2018','20:20'),
	(9,1,3,2,'30/11/2018','18:50'),
	(10,1,2,4,'30/11/2018','22:50'),
	(11,2,1,1,'01/12/2018','13:15'),
	(12,2,1,2,'01/12/2018','16:00'),
	(13,2,1,3,'01/12/2018','18:30'),
	(14,2,1,2,'01/12/2018','20:35'),
	(15,2,1,2,'02/12/2018','13:05'),
	(16,2,2,5,'02/12/2018','13:00'),
	(17,2,2,1,'02/12/2018','15:10'),
	(18,2,2,3,'02/12/2018','17:40'),
	(19,2,2,4,'30/11/2018','13:20'),
	(20,2,2,1,'30/11/2018','16:00'),
	(21,2,2,5,'30/11/2018','18:20'),
	(22,2,1,3,'30/11/2018','14:10'),
	(23,2,1,4,'30/11/2018','16:15'),
	(24,2,2,1,'30/11/2018','18:30'),
	(25,2,2,2,'30/11/2018','20:45'),
	(26,3,2,3,'01/12/2018','13:25'),
	(27,3,1,1,'01/12/2018','13:00'),
	(28,3,1,3,'01/12/2018','15:40'),
	(29,3,2,4,'01/12/2018','16:00'),
	(30,3,2,5,'02/12/2018','13:05'),
	(31,3,1,4,'02/12/2018','13:20'),
	(32,3,2,2,'02/12/2018','15:00'),
	(33,3,1,5,'30/11/2018','13:00'),
	(34,3,2,1,'30/11/2018','14:00'),
	(35,3,2,2,'30/11/2018','17:30'),
	(36,4,1,5,'01/12/2018','13:00'),
	(37,4,2,3,'01/12/2018','14:05'),
	(38,4,3,1,'01/12/2018','13:30'),
	(39,4,4,4,'01/12/2018','13:45'),
	(40,4,5,2,'01/12/2018','15:40'),
	(41,4,1,3,'02/12/2018','13:15'),
	(42,4,2,1,'02/12/2018','15:25'),
	(43,4,3,5,'02/12/2018','17:05'),
	(44,4,4,2,'02/12/2018','14:20'),
	(45,4,5,4,'02/12/2018','15:00'),
	(46,4,1,3,'30/11/2018','13:30'),
	(47,4,2,1,'30/11/2018','14:30'),
	(48,4,3,5,'30/11/2018','15:15'),
	(49,4,4,2,'30/11/2018','18:20'),
	(50,4,5,4,'30/11/2018','16:50'),
	(51,5,4,2,'01/12/2018','13:00'),
	(52,5,4,4,'01/12/2018','15:30'),
	(53,5,2,1,'01/12/2018','13:20'),
	(54,5,1,5,'01/12/2018','14:50'),
	(55,5,3,3,'02/12/2018','13:45'),
	(56,5,1,1,'02/12/2018','15:00'),
	(57,5,3,2,'02/12/2018','16:00'),
	(58,5,4,3,'02/12/2018','13:20'),
	(59,5,2,5,'02/12/2018','17:15'),
	(60,5,1,4,'30/11/2018','13:10'),
	(61,5,3,1,'30/11/2018','14:20'),
	(62,5,1,5,'30/11/2018','18:10'),
	(63,5,1,2,'30/11/2018','21:05'),
	(64,5,4,3,'30/11/2018','15:35'),
	(65,5,2,4,'30/11/2018','17:50');
	
INSERT INTO Reservation
	(_ID,_Screening_ID,_Active)
VALUES
	(1,1,true),
	(2,12,false),
	(3,15,true),
	(4,50,true),
	(5,43,true),
	(6,12,false),
	(7,2,false),
	(8,5,true),
	(9,10,false),
	(10,10,true);

INSERT INTO Seats_Reserved(_Reservation_ID,_Seat_ID)
VALUES
	(1,2),
	(1,3),
	(1,4),
	(1,5),
	(1,6);
