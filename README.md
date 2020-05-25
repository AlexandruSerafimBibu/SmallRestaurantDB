# SmallRestaurantDB

Aceasta baza de date are folosul de a ajuta gestionarea unui restaurant. Sunt existente relatii intre clienti, angajati, mese si comenzi,de asemenea este trecut si un orar de functionare a restaurantului.
Un client poate fi servit de unul sau mai multi angajati. De asemenea, un angajat poate servi unul sau mai multi clienti.
O comanda este o legatura intre client, angajat si un obiect din meniu.
La o masa pot sta unul sau mai multi clienti.
Versiunea folosita pentru crearea bazei de date este Oracle 12c release 2 pentru Windows.

![](Diagrama%20conceptuala.png)

# Cerinte pentru proiect:
1. Afiseaza numele clientilor din baza de date.
2. Afiseaza datele despre clientii din baza de date.
3. Afiseaza suma comenzilor clientului de la masa cu numarul "nr_masa". Daca masa este ocupata de mai multi clienti, atunci da eroare.
3. Dandu-se numarul mesei "nr_masa" afiseaza numele clientilor care au fost serviti la masa aceea si numele angajatilor care i-au servit.
4. Sa se implementeze regula "Nu se pot plasa comenzi in afara orelor de lucru al restaurantului" folosindu-se un trigger.
5. Se se implementeze regula "Angajatii nu pot avea salariu mai mic de 1450 de lei" cu ajutorul unui trigger.
6. Sa se implementeze o metoda de a putea vedea cine creaza tabele in baza de date cu ajutorul unui trigger.

