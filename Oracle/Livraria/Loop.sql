DECLARE
    vTentativa Binary_Integer := 0;
BEGIN
    LOOP
        vTentativa := vTentativa + 1;
        IF vTentativa > 3 THEN
            EXIT;
        END IF;
        DBMS_OUTPUT.PUT_LINE(vTentativa);
    END LOOP;
END;

DECLARE
    vTentativa Binary_Integer := 0;
BEGIN
    WHILE vTentativa < 5 LOOP
        DBMS_OUTPUT.PUT_LINE(vTentativa);
        vTentativa := vTentativa + 1;
    END LOOP;
END;

BEGIN
    FOR i IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;

BEGIN
    FOR i IN REVERSE 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;