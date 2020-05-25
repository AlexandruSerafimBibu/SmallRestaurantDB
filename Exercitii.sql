CREATE OR REPLACE FUNCTION EXERCITIU_8
(nr_masa IN mese.masa_id%type)
return MENIU.pret%type
IS
    TYPE pret_list IS TABLE of meniu.pret%type INDEX BY binary_integer; 
    v_preturi pret_list;
    nume_client clienti.nume%type;
    id_cl clienti.client_id%type;
    suma meniu.pret%type;
BEGIN
    select c.nume, c.client_id into nume_client, id_cl
    from clienti c join loc_la_masa l on (c.client_id = l.client_id)
    where l.masa_id = nr_masa;
    suma := 0;
    select pret bulk collect into v_preturi
    from meniu m join comanda c on (m.fel_mancare_id = c.fel_mancare_id)
    where c.client_id = id_cl;
        
    for elem in 1..v_preturi.count loop
        suma := suma + v_preturi(elem);
    end loop;
    dbms_output.put_line('Clientul: ' || nume_client || ' a comandat in valoare de: '|| suma);
    return suma;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu se afla nimeni la masa cu nr: ' || nr_masa);
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Sunt mai mult de 1 client la masa cu nr:' || nr_masa);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
END;
/

begin
dbms_output.put_line( EXERCITIU_8(3));
end;
/
begin
dbms_output.put_line( EXERCITIU_8(1));
end;
/
begin
dbms_output.put_line( EXERCITIU_8(2));
end;
/

CREATE OR REPLACE PROCEDURE EXERCITIU_9 
(nr_masa mese.masa_id%type)
IS
    TYPE client_list IS TABLE of clienti.client_id%type INDEX BY binary_integer;
    TYPE angajat_list IS TABLE of angajati.nume%type INDEX BY binary_integer;
    v_clienti client_list;
    v_angajati angajat_list;
BEGIN
    SELECT c.client_id BULK COLLECT INTO v_clienti
    FROM mese m join loc_la_masa l on (m.masa_id = l.masa_id)
                join clienti c on (c.client_id = l.client_id)
    WHERE m.masa_id = nr_masa;
    if v_clienti.count >= 1 then
        dbms_output.put_line('Numar clienti serviti la masa cu nr ' || nr_masa || ': ' || v_clienti.count);
        FOR elem in 1..v_clienti.count loop
            select a.nume bulk collect into v_angajati
            from clienti c join serveste s on (c.client_id = s.client_id) 
                           join angajati a on (a.angajat_id = s.angajat_id)
            where c.client_id = v_clienti(elem);
            dbms_output.put_line('Client: ' || v_clienti(elem));
            for elem1 in 1..v_angajati.count loop
                dbms_output.put_line('Angajat: ' || v_angajati(elem1));
            end loop;
            dbms_output.put_line('');
        end loop;
    else
        dbms_output.put_line('Niciun client nu a fost servit la masa cu nr:' || nr_masa);
    end if;
END;
/

BEGIN
EXERCITIU_9(1);
END;
/
BEGIN
EXERCITIU_9(2);
END;
/
BEGIN
EXERCITIU_9(3);
END;
/

CREATE OR REPLACE TRIGGER trig1_exercitiu_10
    BEFORE INSERT OR UPDATE ON COMANDA
DECLARE
    TYPE ore_list IS TABLE OF program.ore%TYPE INDEX BY binary_integer;
    program_zi_curenta ore_list;
    zi_curenta varchar2(20);
    ora_curenta varchar2(20);
    ora_test_start varchar2(20);
    ora_test_end varchar2(20);
    ok number(1);
BEGIN

    select to_char (CURRENT_DATE, 'DAY', 'nls_date_language = ROMANIAN') into zi_curenta from dual;
    select to_char (CURRENT_DATE, 'HH24:MM', 'nls_date_language = ROMANIAN') into ora_curenta from dual;
    
    select ore bulk collect into program_zi_curenta
    from program
    where UPPER(nume) = trim(zi_curenta);
    
    ok := 0;
    FOR elem in 1..program_zi_curenta.count LOOP
        ora_test_start := SUBSTR(program_zi_curenta(elem),1,5);
        ora_test_end   := SUBSTR(program_zi_curenta(elem),7,11);
        dbms_output.put_line(program_zi_curenta(elem) || ' ' || ora_test_start || ' ' || ora_test_end || ' '|| ora_curenta);
        IF (ora_curenta > ora_test_start and ora_curenta < ora_test_end) THEN
        
            ok := 1;
        END IF;
    END LOOP;
    IF (ok = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'tabelul nu poate fi actualizat');
    END IF;
END;
/

/* Pentru a testa trigger-ul trebuie introduse anumite date*/
DELETE FROM PROGRAM WHERE NUME = 'Vineri';
INSERT INTO PROGRAM VALUES(10,'Vineri', '12:00-17:00');
INSERT INTO COMANDA VALUES(1,3,1);

CREATE OR REPLACE TRIGGER trig2_exercitiu_11
    BEFORE INSERT OR UPDATE OF salariu ON angajati
    FOR EACH ROW
    
BEGIN
    IF(:NEW.salariu < 1450) THEN
        RAISE_APPLICATION_ERROR(-20002,'Salariu ales este prea mic');
    END IF;
END;
/

ALTER TABLE angajati
ADD salariu NUMBER(4);

UPDATE ANGAJATI
SET SALARIU = 1300
WHERE angajat_id = 1;
insert into angajati values (100, 'Test trigger', 'Test trigger, Ploiesti', 'testr' ,'Test trigger', 1200);

CREATE TABLE audit_trigger
 (utilizator VARCHAR2(30),
 nume_bd VARCHAR2(50),
 eveniment VARCHAR2(20),
 nume_obiect VARCHAR2(30),
 data DATE);

CREATE OR REPLACE TRIGGER trig3_exercitiu_12
 AFTER CREATE ON SCHEMA
BEGIN
 INSERT INTO audit_trigger
 VALUES (SYS.LOGIN_USER, SYS.DATABASE_NAME, SYS.SYSEVENT,
 SYS.DICTIONARY_OBJ_NAME, SYSDATE);
END;
/

create table test_table_1( idd number);