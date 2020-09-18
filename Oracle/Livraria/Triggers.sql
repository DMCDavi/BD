CREATE OR REPLACE TRIGGER TR_MENOR_16_ANOS
BEFORE INSERT OR UPDATE
ON TB_AUTOR
FOR EACH ROW
DECLARE vIdade INT;
BEGIN
    vIdade := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM :NEW.Data_Nascimento);
    IF (vIdade = 16) THEN
        IF (
            EXTRACT (MONTH FROM SYSDATE) >
            EXTRACT (MONTH FROM :NEW.Data_Nascimento)
        ) THEN
            vIdade := vIdade - 1;
        END IF;
    END IF;
        
        IF ( vIdade < 16 ) THEN
            RAISE_APPLICATION_ERROR(-20301, 'Autor nao pode ter menos de 16 anos');
        END IF;
END;

INSERT INTO TB_AUTOR VALUES (SQ_AUTOR.NEXTVAL, 'Mario', 'M', '10.10.2012');