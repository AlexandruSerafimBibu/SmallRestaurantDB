CREATE TABLE MESE(
masa_id NUMBER PRIMARY KEY,
ocupata NUMBER(1) NOT NULL CHECK (ocupata in (0,1))
);
CREATE TABLE CLIENTI(
client_id NUMBER PRIMARY KEY,
nume VARCHAR(50),
varsta NUMBER(3) NOT NULL CHECK (varsta < 130 and varsta > 0),
adresa VARCHAR(255),
nr_telefon VARCHAR(10)
);
CREATE TABLE ANGAJATI(
angajat_id NUMBER PRIMARY KEY,
nume VARCHAR(50) NOT NULL,
adresa VARCHAR(255),
nr_telefon VARCHAR(10) NOT NULL,
functie VARCHAR(30) NOT NULL
);
CREATE TABLE MENIU(
fel_mancare_id NUMBER PRIMARY KEY,
nume VARCHAR(50) NOT NULL,
pret NUMBER(5,2) NOT NULL
);
CREATE TABLE PROGRAM(
zi_id NUMBER PRIMARY KEY,
nume varchar(10)NOT NULL,
ore varchar(12)NOT NULL
);
CREATE TABLE LOC_LA_MASA(
client_id NUMBER,
masa_id NUMBER,
PRIMARY KEY (client_id, masa_id),
FOREIGN KEY (client_id) REFERENCES CLIENTI(client_id),
FOREIGN KEY (masa_id) REFERENCES MESE(masa_id)
);
CREATE TABLE SERVESTE(
angajat_id NUMBER,
client_id NUMBER,
PRIMARY KEY (angajat_id, client_id),
FOREIGN KEY (client_id) REFERENCES CLIENTI(client_id),
FOREIGN KEY (angajat_id) REFERENCES ANGAJATI(angajat_id)
);
CREATE TABLE COMANDA(
client_id NUMBER,
fel_mancare_id NUMBER,
angajat_id NUMBER,
PRIMARY KEY (client_id, angajat_id, fel_mancare_id),
FOREIGN KEY (client_id) REFERENCES CLIENTI(client_id),
FOREIGN KEY (angajat_id) REFERENCES ANGAJATI(angajat_id),
FOREIGN KEY (fel_mancare_id) REFERENCES MENIU(fel_mancare_id)
);

INSERT INTO MESE VALUES(1,0);
INSERT INTO MESE VALUES(2,0);
INSERT INTO MESE VALUES(3,0);
INSERT INTO MESE VALUES(4,0);
INSERT INTO MESE VALUES(5,0);
INSERT INTO MESE VALUES(6,0);
INSERT INTO MESE VALUES(7,0);
INSERT INTO MESE VALUES(8,0);
INSERT INTO MESE VALUES(9,0);
INSERT INTO MESE VALUES(10,0);
INSERT INTO MESE VALUES(11,0);

INSERT INTO CLIENTI (client_id, nume, varsta, adresa, nr_telefon) 
VALUES(1, 'Bibu Serafim', 21, 'Str Catinei, Ploiesti' , '0723180043');
INSERT INTO CLIENTI VALUES(2,'Budianu Lucian',22,'Str Alcoolului, Vaslui','0723180042');
INSERT INTO CLIENTI VALUES(3,'Dumbrava Razvan',21,'Str Dacia, Pitesti','0730692208');
INSERT INTO CLIENTI (client_id, nume, varsta, nr_telefon)
VALUES(4,'Bozdog Alexandru',23,'0732692208');
INSERT INTO CLIENTI (client_id, nume, varsta, adresa)
VALUES(5,'Dogaru Alice',22,'Str Cameliei, Ploiesti');
INSERT INTO CLIENTI VALUES(6,'Bibu Andrei',23,'Str Catinei, Ploiesti','0721328999');


INSERT INTO ANGAJATI (angajat_id, nume, nr_telefon, functie)
VALUES (1, 'Don Quihote', '0723184425' ,'Chelner');
INSERT INTO ANGAJATI (angajat_id, nume, nr_telefon, functie)
VALUES (2, 'Luigi Mario', '0724424424' ,'Chelner');
INSERT INTO ANGAJATI VALUES (3, 'Luca Violeta', 'Str Republicii, Ploiesti', '0724424424' ,'Manager');
INSERT INTO ANGAJATI (angajat_id, nume, nr_telefon, functie)
VALUES (4, 'Uscatura Razvan', '0723405536', 'Barman');


INSERT INTO MENIU VALUES (1, 'Pizza Quatro Stagionni', 23.54);
INSERT INTO MENIU VALUES (2, 'Pizza Quatro Formagi', 21.22);
INSERT INTO MENIU VALUES (3, 'Burger cu de toate', 33.33);
INSERT INTO MENIU VALUES (4, 'Cartofi Prajiti', 8.99);
INSERT INTO MENIU VALUES (5, 'Paste Carbonara', 24.99);
INSERT INTO MENIU VALUES (6, 'Paste Bolognese', 22.99);
INSERT INTO MENIU VALUES (7, 'Paste Al Forno cu Pui si Ciuperci', 29.99);
INSERT INTO MENIU VALUES (8, 'Cuba Libre', 8.99);
INSERT INTO MENIU VALUES (9, 'Bere Becks', 5.99);
INSERT INTO MENIU VALUES (10, 'Limonada cu menta', 9.99);
INSERT INTO MENIU VALUES (11, 'Fresh de Portocale', 9.99);

INSERT INTO PROGRAM VALUES (1, 'Luni', '10:00-22:00');
INSERT INTO PROGRAM VALUES (2, 'Marti', '10:00-22:00');
INSERT INTO PROGRAM VALUES (3, 'Miercuri', '10:00-22:00');
INSERT INTO PROGRAM VALUES (4, 'Joi', '10:00-22:00');
INSERT INTO PROGRAM VALUES (5, 'Duminica', '10:00-22:00');
INSERT INTO PROGRAM VALUES (6, 'Vineri', '10:00-24:00');
INSERT INTO PROGRAM VALUES (7, 'Sambata', '10:00-24:00');

INSERT INTO SERVESTE VALUES(1, 2);
INSERT INTO SERVESTE VALUES(1, 3);
INSERT INTO SERVESTE VALUES(1, 1);
INSERT INTO SERVESTE VALUES(1, 4);
INSERT INTO SERVESTE VALUES(2, 5);
INSERT INTO SERVESTE VALUES(2, 6);
INSERT INTO SERVESTE VALUES(4, 1);
INSERT INTO SERVESTE VALUES(4, 3);
INSERT INTO SERVESTE VALUES(4, 4);
INSERT INTO SERVESTE VALUES(4, 5);

INSERT INTO LOC_LA_MASA VALUES(1,1);
INSERT INTO LOC_LA_MASA VALUES(2,2);
INSERT INTO LOC_LA_MASA VALUES(3,2);

INSERT INTO COMANDA VALUES(1,1,1);
INSERT INTO COMANDA VALUES(1,2,1);